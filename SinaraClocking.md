# Notes on wr

[WR Low Jitter](https://www.ohwr.org/projects/wr-low-jitter/wiki/wiki) is a great resource:
- [TCVCXOs](https://www.ohwr.org/projects/wr-low-jitter/wiki/phase-noise-and-adev-of-the-wr-switch-using-different-tcvcxos)
- For an OCXO we could go for Morion MV272M
- [Picking the right DAC for a digital PLL](https://www.ohwr.org/documents/496)
- [Transceiver stability/noise](https://www.ohwr.org/documents/528)
  - SFPs/optical fibre don't contribute noticeable noise, (although, note that wr servos the total fibre path length out at a rate of 1Hz): ``the stability at Tau=1...10s is below 1E-13 for both fiber length (3 meters and 10 km). This is a very good stability performance that is better than an  H-Maser  clock.``
  - Gives recommended transceiver settings.
  - ``Newer FPGAs have also the feature to redirect the recovered clock directly to the output pins without  using  the  internal  clock  distribution,  but  an investigation is  needed  to  assess  the  performance.``
  - Transceiver noise not as good as a H-maser, but still looks pretty good. Need to read the note more carefully, but looks the Gtx recovered clock is about -105dBc/Hz at 1Hz offset (figure 3.11) a FS725 rubidium standard is about -105dBc/Hz at 1Hz offset, -135dBc/Hz at 10Hz offset. 
 
# Time distribution in Sinara

Based on:

  * Discussions on the #m-labs IRC channel (2016-08-23, 2016-08-29, 2016-08-30, 2016-09-13, 2016-08-29 among others).
  * Discussions during the Warsaw meeting.
  * [e-mail thread](https://ssl.serverraum.org/lists-archive/artiq/2016-September/001007.html)

## Crate clock distribution

The crate distributes a 100MHz clock on a RTM RF backplane. This clock is typically externally supplied from a high quality source, but it is desirable to include a 100 MHz oscillator on the MCH RTM and on the Sayma RTM the for turnkey/standalone operation (with limited timing performance).

In a multi-crate system, all crates need to receive the same 100MHz clock to support sample-accurate operation.

## RTIO

Sayma and Metlino shall include a general purpose XO of e.g. 125MHz, connected to a general purpose FPGA clock input pin. This is a simple addition that make the boards a bit friendlier to developers. 
It also allows for debugging and bootstrapping of the clocks during development: This XO becomes necessary if we use a transceiver PLL chip that needs to be configured before it outputs a clock.

### Metlino

In root mode, the Metlino receives the 100MHz clock and turns it into a 200MHz RTIO clock that it uses as reference clock for its DRTIO transmitters.

In satellite mode, the Metlino recovers the RTIO clock from the fiber.

The following clock resources should be available on Metlino to support this operation:

  * Si5324 for 100->200MHz in root mode, and CDR jitter filtering in satellite mode.
  * Si5324 free-running based on local XO for providing a CDR reference in satellite mode.

The Si5324 shall have its two clock outputs connected to a transceiver clock input (so that we can transmit back synchronously and at fixed latency) and to a general purpose clock input on the FPGA. Transceiver-fabric clock routing inside the FPGA is of poor quality, so we want to mitigate that.

The Metlino will be double-width and connected to its RTM to receive the 100MHz RTM clock (required in root mode).

### Sayma

Sayma cards recover their RTIO clock from the backplane's transceiver link or - if they are stand-alone -- from their SFP/SATA DRTIO transciever link.
This requires the same hardware as the Metlino in root mode: Si5324 connected in the same way.

## DRTIO

DRTIO (distributed real-time input/output) achieves three distinct things over a single high speed serial link:

  * It transfers the RTIO clock
  * It transfers the RTIO time.
    This means that it will designate a specific RTIO clock cycle as timestamp zero.
  * It transfers data.
    Data consists of RTIO events (outputs or inputs) and low bandwidth non-realtime auxiliary traffic.

Note that the RTIO time (clock plus the cycle counter) is the primary and authoritative source of time in the ARTIQ tree.
The RTIO clock is however not an extremely low noise clock that could serve as the sample clock in data conversion or as a base clock for picosecond level timestamping.
Having another "better" clock do these tasks is not trivial since the alignment between such a sample clock and the RTIO clock is unknown.
When data is transferred between the two clock domains it is undefined which RTIO cycle corresponds to which sample clock cycle.

## JESD204 synchronization procedure

While JESD204B subclass 1 provides "fixed latency" for the data transfer between a converter (ADC or DAC) and the FPGA, this is fundamentally insufficient for DRTIO.
We need more than just fixed latency.
A JESD204B link has two deviceclocks: one for the converter and one for the FPGA. The SYSREF signal is used to designate which cycle of the faster of the two deviceclocks corresponds to the beginning of a cycle in the slower deviceclock. The slower deviceclock and SYSREF have an a priori unknown phase with respect to the RTIO clock.

Timestamping a certain sample to a specific RTIO cycle requires two things in addition to JESD204B subclass 1 deterministic latency:

  * Reproducible alignment of the sample clock with the RTIO clock.
    This is guaranteed by fixed latencies in the DRTIO branch of the clocking
    (master oscillator -> MCH RTM -> Metlino -> AMC backplane DRTIO link -> Sayma AMC)
    and in the sample branch
    (master oscillator -> MCH RTM -> RF backplane -> Sayma RTM -> PLL -> clock distribution -> DAC/ADC).
    This also requires the backplane clock and the sample clock to be integer multiples of the RTIO clock.
  * Reproducible alignment of SYSREF and the slower FPGA deviceclock to the RTIO clock.
    This is done actively.

The FPGA shall align SYSREF with designated RTIO clock edges. The alignment should be better than a DAC clock cycle and reproducible across reboots.

The FPGA first roughly aligns SYSREF within one cycle before a desired RTIO clock edge by asserting the synchronization signal of the clock chip, which resets its dividers.
This alignment is optional and may have an uncertainty of several DAC clock cycles.
It is only used to decrease the required scan range of the delay elements used in the next steps.

The FPGA then analyzes SYSREF by repeatedly sampling it with the RTIO clock while scanning a calibrated I/O input delay.
This measures the SYSREF phase with a high precision.

The delay scan mechanism is limited by the resolution and stability of the scan element. The resolution must be significantly smaller than a DAC clock period.
There are three delay elements available to perform the scan:
  
  * IDELAYE3 in the FPGA. Uncertainty about PVT effects.
  * Digital delay in the clock distribution chip. Infinite delay, low noise.
  * Analog delay in the clock distribution chip (HMC704X only, not AD9516-1).
    Very fine and well calibrated, but too noisy to be used on a sample clock.

We plan to use the latter two elements for the scan.

The FPGA then rounds the phase to an integer multiple of sample clock cycles using previously stored fractional delay data (delay <- round(measured - fractional)) and stores the new fractional delay (fractional <- measured - delay).
It now programs the digital phase shifters of the slower clocks (FPGA deviceclock and SYSREF) with the negative of the rounded delay value.

This technique can be implemented on the AD9154 FMC cards, using the digital delay of the AD9516-1 and IDELAYE3.

## Sayma RTM clock chip connections

The HMC7044 has 14 outputs. We should use them for:

  * DAC1 deviceclock
  * DAC1 SYSREF
  * DAC2 deviceclock
  * DAC2 SYSREF
  * ADC1 deviceclock
  * ADC1 SYSREF
  * ADC2 deviceclock
  * ADC2 SYSREF
  * FPGA SYSREF [with fine delay]
  * FPGA MGT reference clock for DAC
  * FPGA MGT reference clock for ADC
  * additional outputs to FPGA, usable e.g. if we have problems with the recovered RTIO clock.

## Clock constraints

### Constraints

  * t_RTIO = n * 1ns
    * period of the coarse RTIO clock
    * n integer to avoid rounding errors and beating between RTIO clock and user habit
    * n not necessarily a power of two
    * the same throughout the ARTIQ tree to avoid beating of channels
  * t_DRTIO_link = n * 10 * t_RTIO with n being 1, 2, 4, 8
    * line period of the DRTIO link
    * due to 8b10b and parallel bus width
    * n not a power of two could work but looks impractical.
    * does not need to be the same n for each link
    * AMC backplane links can probably not to 10 GHz line rate but 5 GHz, fibers (SFP+) can
  * t_SAWG_DATA = t_RTIO/

```
f_DAC/f_SAWG: {1, 2, 4, 8}
f_SAWG/f_RTIO: {1, 2, 4, 8}
f_RTIO/f_DRTIO: {10, 20, 40}
f_JESD_P/f_RTIO: {1, 2}
f_JESD/f_JESD_P: {40}
```

| (GHz) | f_DAC | f_SAWG | f_JESD_P | f_JESD | f_RTIO | f_DRTIO |
| ----- | ----- | ------ | -------- | ------ | ------ | ------- |
| A     | 2.4   | 0.6    | 0.15     | 6      | 0.15   | 3       |
| B     | 2     | 1      | 0.25     | 10     | 0.125  | 5       |
| C     | 0.3   | 0.3    | 0.15     | 6      | 0.15   | 3       |