**Some of this is obsolete/incorrect. In due course, it will be merged with the Artiq Documentation.**

Specification and design concept for a high data rate, multi-tone,
interpolating, scalable, smart, high-speed arbitrary waveform generator.

#### Spline parametrization

*This is inherited from the [pdq2
documentation](http://pdq2.readthedocs.io/en/latest/)*

The method of compression is a polynomial basis spline (B-spline). The
data consists of a sequence of knots. Each knot is described by a
duration `$\Delta t$` and spline coefficients `$u_{n}$` up to order `$k$`. If
the knot is evaluated starting at time `$t_{0}$`, the output `$u(t)$` for
`$t\in[t_{0},t_{0}+\Delta t]$` is
`$$u(t)=\sum_{n=0}^{k}\frac{u_{n}}{n!}(t-t_{0})^{n}=u_{0}+u_{1}(t-t_{0})+\frac{u_{2}}{2}(t-t_{0})^{2}+...$$`
A sequence of such knots describes a spline waveform. From one discrete
time `$i$` to the next `$i+1$` each accumulator `$v_{n,i}$` is incremented by
the value of the next higher order accumulator:
`$$v_{n,i+1}=v_{n,i}+v_{n+1,i}$$` For a cubic spline the mapping between
accumulators’ initial values `$v_{n,0}$` and the polynomial derivatives or
spline coefficients `$u_{n}$` can be done off-line and must take into
consideration the finite time step size `$\tau$`. The data for each knot
is described by the integer duration `$T=\Delta t/\tau$` and the initial
values `$v_{n,0}$`. This representation allows both transient
large-bandwidth waveforms and slow but smooth large duty cycle waveforms
to be described very efficiently.

#### Waveform parametrization

The gateware will support at least 8 independent channels.

Each channel emits waveforms of the general parametrization:
`$$z=\left( a_1e^{i(f_1 t+p_1)} + a_2e^{i(f_2 t+p_2)}\right)e^{i(f_0t+p_0)}$$`
`$$o=u+b_0\mathrm{Re}(z)+b_1\mathrm{Im}(z^\prime)$$`

-   `$o$` is the (real valued) output of a channel

-   `$z$` is the complex-valued output of the “generator” associated with
    each channel

-   `$z^\prime$` is the complex-valued output from the generator of each
    channel’s “buddy” channel. Two adjaccent channels form a buddy pair.
    This enables seamless usage of the complex data path features in
    DACs, complex (IQ) analog modulation, and yields “four-tone” support
    on IQ channels for free.

-   `$u$` and `$a$` are 16-bit cubic (third order) spline interpolators

-   `$p$` are 16-bit constant (zeroth order) spline interpolators

-   `$f$` are 48-bit linear (first order) interpolators

-   `$b$` are switches (`$1$` or `$0$`)

#### Datapath details

-   `$f_\mathrm{DATA}\geq1\,\mathrm{GHz}$`. Exact clock speed is TBD and
    depends on simultaneously meeting hardware constraints and an
    integer relationship with the RTIO clock and
    physics/noise requirements.

-   Oscillator `$f_0,p_0$` is sampled at `$f_{DATA}$`

-   Interpolators are updated and interpolate at `$f_\mathrm{DATA}/k$`
    with `$k$` typically 4 or 8 and
    `$f_\mathrm{DATA}/k \geq 125\,\mathrm{MHz}$`

-   Oscillators `$f_{1,2},p_{1,2}$` are sampled at `$f_{DATA}/k$`

-   All amplitude summing junctions shall implement saturating summation
    to prevent wrap-around.

-   All amplitude summing junctions shall implement configurable and
    guaranteed gateware low-high limiters.

-   All amplitude summing junctions shall register saturation events.

-   To up-sample the data from the `$f_1$`,`$f_2$` oscillators by `$k$` before
    passing it into the `$f_0$` oscillator, a CIC filter of order TBD
    shall be implemented for anti-aliasing. CIC filters are
    linear phase.

-   To implement further anti-aliasing, a symmetric (thus linear phase)
    FIR filter with TBD taps (FPGA DSP resource limits) shall be
    implemented after the CIC filter.

-   All spline interpolators and the total channel output shall be
    monitored by the ARTIQ channel monitoring infrastructure.

-   All spline interpolators shall support ARTIQ injection/override.

#### Clocking and synchronization

-   Timestamps for spline knot scheduling are at least 62 bit wide.

-   Spline knots have 16-bit dynamic range in time.

-   In order to support slower sweeps with sparser spline knots, the
    dynamic range of the spline coefficients can be extended using time
    stretcher. It decelerates the spline evolution/interpolation rate by
    a factor of `$2^E$`.

-   Waveform output shall be with deterministic latency with respect to
    the RTIO clock:

    -   across channels on the same card (to within DAC
        chip specification)

    -   across cards in the same rack (to within DAC chip and intra-rack
        DRTIO clock sycnchronization)

    -   across racks controlled by the same core device (to within DAC
        chip and DRTIO clock synchronization)

-   Each card can be clocked by an internal DAC clock derived from the
    RTIO clock or by an external DAC clock.

-   When an external DAC clock is used, the waveform synchronization is
    ensured to within one DAC clock cycle (or the limit of the DAC chip
    whichever is higher) but below that depends on the phase of the
    external DAC clock.

-   All spline knot interpolators can be updated independently (and
    also simultaneously) of each other.

-   All spline interpolator latencies from the internal “RTIO clock
    reference plane” to the DAC output are matched and deterministic.
    Channel and board latencies are matched and deterministic
    (see above).

-   Minimum spline knot duration is `$k/f_\mathrm{DATA}$`.

#### Phase update modes

The phase accumulator of the DDS cores can be updated in multiple
different modes during a phase and/or frequency update.

-   relative phase update:
    `$q^\prime(t) = q(t^\prime) + (p^\prime - p) + (t - t^\prime) f^\prime$`

-   absolute phase update:
    `$q^\prime(t) = p^\prime + (t - t^\prime) f^\prime$`

-   phase coherent update: `$q^\prime(t) = p^\prime + (t - T) f^\prime$`,
    where

-   `$q$`/`$q^\prime$`: old/new phase accumulator

-   `$p$`/`$p^\prime$`: old/new phase offset

-   `$f^\prime$`: new frequency

-   `$t^\prime$`: timestamp of setting new `$p$`,`$f$`

-   `$T$`: “origin” timestamp: beginning of experiment, boot of device, or
    arbitrary

-   `$t$`: running time

Relative phase updates are called “continuous phase mode” and coherent
updates are called “tracking phase mode” by some. Phase coherent updates
can be mapped (in software/runtime) to absolute phase updates by
transforming
`$p^\prime \longrightarrow p^\prime + (t^\prime - T) f^\prime$`. Since
phase coherent updates require large multiplications is is questionable
whether they can and should be implemented in gateware.

It is questionable whether phase coherent updates should or even can be
supported for sweeping `$p$`/`$f$`. They can be supported for the modulation
inputs (see below).

#### Modulation by RTIO

To each spline interpolator (any of the nine `$f,p,a,u$` in the waveform
parametrization) a modulation (summarized as `$e_\mathrm{RTIO}$`) by a
separate RTIO channel can be applied.

-   The modulation is an additive offset for frequency and phase (`$f,p$`)
    and a multiplicative offset for amplitudes (`$u,a$`).

-   The modulation is times like any other (non-interpolating) RTIO
    event, i.e. `$\leq 8$`ns time resolution and has the same value
    resolution as the spline interpolator it modulates.

-   Default values are 0 for frequency and phase modulation (`$f,p$`) and
    1 for amplitude modulation (`$u,a$`).

-   Modulation is normalized to full scale.

#### Modulation by local DSP

In addition to RTIO modulation `$e_\mathrm{RTIO}$` there is “local DSP”
modulation input to each spline interpolator.

-   Same specifications and semantics as the RTIO modulation.

#### Local DSP

A fully reconfigurable local DSP fabric with multiple IIR filters shall
be included. The DSP switchyard supports servoing applications of
various types.

-   See [redpid](https://github.com/jordens/redpid) for a rough
    feature set.

#### Runtime and kernel interface

-   Spline knot sequences can be generated off-line and embedded in
    ARTIQ experiments.

-   Spline knot sequences can be generated at compile time.

-   Spline knot sequences can be embedded into ARTIQ experiments and
    emitted to from the core device to the DRTIO channels during
    the experiments.

-   Spline knot sequences can be computed dynamically on core device.

-   Instead of emitting them directly to the DRTIO channel, spline knot
    sequences can be emitted into a named DMA context which stores the
    RTIO events in memory (either on the core device or right at the
    DRTIO channel in the card’s DRAM) for later recall.

-   Stored, named DMA segments can be replayed by name.

-   Given enough slack to transmit DRTIO events and fill the channel
    FIFOs (from core device or from any DMA source), all boards, all
    channels, all splines can burst `$\geq128$` knots each at `$\geq125$`MHz
    (BRAM FIFO limited). This is independent of whether the events are
    computed dynamically, off-line, embedded, reside in core device DRAM
    or remote DRAM.

-   When sourcing waveforms from core device memory, the sustained
    aggregated spline knot rate across all interpolators is `$\geq2$`MHz.

-   Sourcing from remote DRTIO DMA the spline knot rate per board
    (aggregated over all channels and all interpolators on that board)
    is TBD MHz sustained for TBD knots (DRAM limited).

-   Supports setting `$e_\mathrm{DRTIO}$` using standard DRTIO events.

-   Supports configuring the DAC through RTIO-SPI

-   Utility functions shall be made available to users for processing
    spline waveforms (scaling in value and time, resampling).

-   Given a periodically sampled waveform (vector of values) routines
    shall

    -   generate a spline waveform with a fixed knot duration

    -   generate a spline waveform with specified knot count and
        variable knot duration

    -   generate a spline waveform with minimal knot count and specified
        RMS error

-   given user-supplied spline waveform routines shall

    -   generate a periodically sampled waveform (vector of values) with
        user specified resolution

    -   determine validity (in-range)

#### Test Cases

ARTIQ Python programs demonstrating the following will be provided.

1.  Simultaneous generation of two-tone waveforms on 8 DAC channels
    where `$f_{1}=f_{0}+\Delta$` and `$f_{2}=f_{0}-\Delta$` where
    `$f_{0}=200$` MHz and `$\Delta=[0,50]$` MHz.

2.  Playing a spline knot sequence demonstrating each spline
    interpolator in turn.

3.  Replaying a 128 knot two-tone amplitude sequence from remote DMA.

4.  Phase/frequency/amplitude shifting that sequence using
    `$e_\mathrm{DRTIO}$`.

5.  Demonstrate relative and absolute phase mode.

6.  Demonstrate deterministic channel alignment to one DAC clock cycle.

7.  Demonstrate external and internal clocking.


### Sayma SAWG data rate constraints

The fast smart arbitrary waveform channels require a significant amount
of logic resources but also necessitate fulfilling several interacting
constraints on operating frequencies and clock ratios.

For the DAC channel data rate `$f_\mathrm{DATA}$` on the JESD204B link,
the following rules need to be observed.

-   `$t_\mathrm{DATA} = t_\mathrm{RTIO\_FINE}$`. DAC samples need to mesh
    with RTIO timestamps (e.g. RF switches on TTLs and SYS\_REF
    tagging), otherwise DAC timing is not sample-accurate and samples
    will beat around RTIO timestamps. The RTIO timestamp granularity is
    a global design variable of an ARTIQ DRTIO fabric instance. The
    granularity does not need to be 1ns and can easily be altered
    globally, but it needs to be the same across the entire DRTIO
    fabric. If e.g. the core device has a coarse clock of 125MHz and the
    high resolution TTL provide three more bits of resolution, then the
    fine timestamp granularity needs to be 1ns (or an
    integer submultiple) everywhere.

-   `$t_\mathrm{SLOWDDS}/k = t_\mathrm{FASTDDS} = t_\mathrm{DATA}$` with
    `$k$` a power of two. The accumulator phasing and datapath
    parallelization methods that allow generating multiple samples in a
    single clock cycle only work for powers of two.

-   `$t_\mathrm{SLOWDDS}$` can potentially be as low as 4ns on Kintex 7
    with speed grade 2 or better, certainly as low as 5ns. The
    possibility of 4ns fabric timing would need to be explored
    and verified.

-   `$t_\mathrm{SLOWDDS} = m t_\mathrm{RTIO\_FINE}$`: The spline
    interpolators, RTIO updates, and the slow DDS should mesh with the
    fine timestamp (e.g. RF switches on TTLs).

-   `$t_\mathrm{SLOWDDS} = p t_\mathrm{RTIO}$`: The spline interpolators,
    RTIO updates, and the slow DDS should mesh with the coarse
    timestamp (e.g. relative to RF switches on coarse TTLs). `$p$` is a
    power of two in the current ARTIQ architecture.

-   `$f_\mathrm{DATA} \leq 1.09\,\mathrm{GHz}$` or even $ \leq
           1.03\,\mathrm{GHz}$ for typical DAC and FPGA transciever
    line rate.

The DAC sample rate `$f_\mathrm{DAC}$` after interpolation and up-sampling
from `$f_\mathrm{DATA}$` needs to satisfy:

-   `$f_\mathrm{DATA} \leq 2.4\,\mathrm{GHz}$`: Typical DAC sample rate

-   `$f_\mathrm{DAC} = q f_\mathrm{DATA}$` with `$q \in \{1, 2, 4, 8\}$`:
    Available interpolation options

#### Logic and RAM

-   ARTIQ device CPU(s) and miscellaneous logic resources provide a good
    estimate for the additional logic required to support DRTIO. The
    kc705-nist\_qc2 design occupies 23k LUT and 5Mb BRAM. The
    pipistrello-nist\_qc1 design uses 15k LUT and 1Mb BRAM (on a
    slightly different architecture).

-   parallelized FIR: 4 channel, 4x parallelism, 30 taps: 240 DSP

-   parallelized HBF + tricks: 4 channel, 4x parallelism, 30 taps: 120
    DSP

-   RTIO FIFOs: 4 channel, 128 knots per RTIO channel: 4Mb

-   PID, extrapolating from redpid (xc7z010): 2 channel 125MHz ADC/DAC +
    misc DSP, full servo crossbar matrix: 13 kLUT, 50 DSP

Several design studies were performed for different configurations of
the Sayma SAWG channels:

-   Sayma initial SAWG on kc705: 2 channel, 8x parallelism, 125MHz: 28k
    LUT

-   Sayma advanced draft SAWG on kc705: 4 channel, 4x parallelism,
    200MHz: 33k LUT

-   Sayma advanced draft SAWG on kc705: 4 channel, 8x parallelism,
    125MHz: 53k LUT

-   Sayma advanced draft SAWG on kc705: 8 channel, 8x parallelism,
    125MHz: 106k LUT

-   Sayma advanced draft SAWG on kcu105: 4 channel 4x parallelism,
    200MHz: 33k LUT

#### Data and sample rates

**Somewhere in the Sayma docs, we should have a page about clock distribution, giving users an overview of the different constrains that exist for clocking. This section should be merged into that and/or the SAWG docs.**
The following choices for data rates and lanes appear to be interesting
(BW: bandwidth; SSB: single sideband; DSB: dual sideband; “size”:
resource usage in units of 13k LUTs per channel):

  `$f_\mathrm{DAC}$` | `$f_\mathrm{DATA}$` | line rate   | lanes   | “size”   | `$f_1,f_2$` DSB BW | BW mix 2nd+3rd
  ------------------ | ------------------- | ----------- | ------- | -------- | ------------------ | ------------------
  2.4GHz             | 600MHz              | 6GHz        | 8       | 4        | 150MHz             | 300–600–900MHz
  2GHz               | 1000MHz             | 10GHz       | 8       | 8        | 125MHz             | 500–1000–1500MHz
  1.6GHz             | 800MHz              | 8GHz        | 8       | 4        | 200MHz             | 400–800–1200MHz
  300MHz             | 300MHz              | 6GHz        | 4       | 2        | 150MHz             | 150–300–450MHz

For 4 JESD lanes, use DAC “mix mode” (switching up-conversion by
`$f_\mathrm{DAC}$`) to emphasize second Nyquist zone from
`$f_\mathrm{DAC}/2$` to `$f_\mathrm{DAC}$`. Zeros at 0Hz and
`$2\times f_\mathrm{DAC}$`.