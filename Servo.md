# Sayma Servo

## Background

* NIST Digital Servo: Leibrandt & Heidecker (2015), https://arxiv.org/abs/1508.06319, https://github.com/nist-ionstorage/digital-servo
* NIST redpid: Jordens (2014), https://github.com/jordens/redpid
* Digital high bandwidth feedback controller: Seidler 2015, http://quantum-technologies.iap.uni-bonn.de/de/diplom-theses.html?task=download&file=284&token=a7b431606e2460eab1d3fc46fb911e85
* PTB RedPitaya based digital Servo
* TOPTICA digital servo


## Design Notes

### Latency/Loop Bandwidth

Latency should be ALARA. Probably with a pi phase shift somewhere
between 200 kHz to 500 kHz, limited by DSP pipeline length (FPGA), JESD latency.

### Data Rate

ADC sampling rate: 125 MHz, 150 MHz, or 75 MHz. Some blocks might
run slower, preceeded/followed by interpolators/up-samplers if necessary.

### Muxes/Configurability

18x25 MACs with single-cycle self-feedback (IIR) are doable in a single cycle, more need longer pipelines.
Given that it seems wise to constrain crossbars to e.g. channel groups of 4, i.e. the input to a signal chain can be one of (4 ADC inputs, 4 SAWG outputs, 4 servo outputs, 4 Spline setpoints).

### RTIO

Configuration registers (Mux settings, IIR tap coefficients, state masks, limits, sweep rates) should to be accessible over RTIO, with one channel per DSP chain.
That allows setting registers simultaneously across DSP chains but only sequentially within a DSP chain. Supporting arbitrary synchronous settings or banked settings seems to be too costly/complicated.

### IIR Dynamic Range

1. Wide multipliers (36x25 or 36x50 instead of 18x25 for DSP48E1) are problematic  from a timing perspective.
2. We need to meet timing to be able to debug/CI/maintain code.
3. Latency is the physically limiting quantity, not data rate/clock rate.
4. Filter poles and zeros tend to be several orders of magnitude below the data rate.
5. IIR filter coefficients tend to max out/be close to the full dynamic range of an IIR filter.

Therefore it seems wise to focus on IIR filters that meet timing and focus on low
frequency poles/zeros. Given that the latency is dominated by other blocks in
the chain, the IIR filters don't necessarily have to have low latency nor do
they need to operate at full data rate.

There seems to be a good opportunity here to do some research on practical IIR
topologies that do full rate but allow extreme coefficients. (meeting timing, reasonably small resource usage, sufficient dynamic rante to represent sub-hertz poles/zeros)


## DSP Chain

* There should be eight DSP chains on a Sayma (as much as there is space)

* One mux-ed (16 fold) input, selectable sign
  * 8 analog inputs
* One fast IIR (bypass)
* Demodulation (phase accu and CORDIC in rotate mode) (bypass) adjustable frequency
* One slow IIR with wide dynamic range and low resource usage (bypass)
* Phase detector (CORDIC in vectoring mode plus wrap counter) (bypass) (TBD:
  there might be a smarter way to do this, i.e. without two CORDICs)
* One mux-ed (16 fold) reference signal, selectable sign, added
  * 1 spline interpolator
  * 1 noise generator with gain
  * 4 analog inputs
  * 4 SAWG outputs
  * 4 PID outputs
* Limiter with configurable limits driving AWU/IH on previous IIRs, resettable
  max/min detectors
* One slow ultra-high dynamic range IIR (bypass)
* Three fast IIR (bypass)
* Sweeper with configurable rate, steered by limiter, added
* Relock with configurable sweep rate, added, driving AWU/IH of previous IIRs, enabled by digital mask
  * limiter states, IIR railed from this and other DSP chains
  * digital inputs
  * window detector on mux-ed signal
    * 4 analog inputs
* Modulator (attenuated LO from Demodulator), added
* Noise generator with gain, added
* Limiter with configurable limits, driving AWU/IH on previous IIRs, resettable
  max/min detectors
* Output mux-ed 16 fold onto the DAC channel interpolator offsets


## Specifications

* Signal path: 25 bits wide fixed point
* Coefficient width: 18 bits for fast IIR with dynamic range tweaks or 35 (maybe 69) bits for ultra high dynamic range slow IIRs


## Items

(in order of implementation priority)

* RTIO register map infrastructure, kernel interface for configuration,
  bypasses, muxes, coefficients, state masks
* Fast 18 bit first order IIR filter
* Improved full rate wide dynamic range IIR filter
* Coefficient generating tools
* "Integrator hold"/"anti-windup" for IIR filters
* Limiters
* Sweeper
* Relock
* PRNG noise generator
* Slow 35/69 bit second order IIR filter
* Demodulator (phase accu, CORDIC in rotate)
* Phase detect (CORDIC in vectoring)
* Modulator with adjustable gain
* FIR filters for up-sampling and downsampling around slow second order IIR
* Persistent settings (flash memory)
* Capture buffer triggered by some window detector on some mux-ed analog
  signal set plus some set of masked binary signals, selectable decimation
  (CIC or HBF) in powers-of-two, fixed size buffer (maybe 1024 samples)
* Symmetric rounding (suppress 1 LSB negative bias due to twos complement)


## Issues

* Handling of latency changes/signal glitches when IIR filters are enabled/disabled or coeffients change
* Monitoring taps within the signal chain for debugging
