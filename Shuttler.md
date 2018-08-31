Follow discussion in [Issue 253](https://github.com/m-labs/sinara/issues/253). 

High-speed, precision multi-channel DAC. Used for e.g. fast shuttling/splitting of ion chains.

AMC specification/thoughts:
- Maybe passive/just repeaters (route lines from BP to RTM directly)? Or, better to have a simple AMC with: FPGA, trigger SMA input (buffered, 5V tolerant, to protect FPGA); some SFPs; maybe an FMC?

RTM specification/thoughts:
- **DAC**: LTC-2000-16
- **Channel count**: 32
- **Front-end**: on separate mezzanine
- **External reference**: LTC6655 or similar low-drift reference
- **Clocking**: clock input options are: RF BP, front panel SMA, CDR clock (low phase noise LVDS mux to select). Low noise PLL, such as HMC830, to generate DAC clock.
- **Front end**: mounted as a mezzanine (with an optional receiver board).

RTM AFE mezzanine 1:
- **Bandwidth**: >10MHz
- **Use case**: to be used with a differential receiver board (see below).
- **Output**: differential driver to drive +-1V into 100ohm cable.
- **Filter**: basic anti-aliasing filter
- **Connector/cable**: Same HD68 pinout as Zotino. If cross-talk is an issue in standard SCSI cables, we can buy custom cables with per-twisted-pair screening (or, plan B, switch to something like using a bundle of cat-7 cables).

Differential receiver board:
- **Bandwidth**: pass band up to 10MHz
- **Use case**: designed to be located as close to trap as possible
- **Output voltage range**: +-10V (ideally, +-20V)
- **Filter**: probably 3rd order (2 order active, 1 order passive). Note that each user will probably want different RC options
- **Output noise/drift**: should not degrade DAC noise/drift significantly in the pass band
- **Load**: 10k in parallel with a few 10s of pf, single-ended
- **Output connector**: simple board-board connector, such as pin-header? (Each user will want to use a different connector). Or, should we pick a sensible connector here? Another HD68?
- **Slew-rate**: sufficient to drive FS sinusoids at 10MHz
- **Input**: HD68, with differential receiver.

AFE mezzanine 2:
- Basically, this will just be the differential receiver board, mounted as an AFE mezzanine on the RTM. i.e. amplifies and filters DAC signal, and produces a single-ended output. Probably still use an HD68 connector, and use CMCs to make it somewhat differential (e.g. as Zotino).
- NB cabling will have to be very short to avoid excessive capacitive loading (will cause degradation of BW, and increased heating of the board).
- One option that would be able to drive a broader variety of loads (at the cost of power dissipation) would be to use the [THS3491](http://www.ti.com/product/THS3491) or similar with gain of 10 to take the DAC outputs to +/- 10V range with high available bandwidth (>100 MHz), low distortion, and low noise (white noise floor ~1.7 nV/rtHz).  Quiescent current dissipation is ~400 mW per channel with +/-15V supplies, so this may be too much.  The [THS3001](http://www.ti.com/product/THS3001) is slightly slower but uses only half the power (~200 mW/channel).

Notes:
- The specified stop band noise for Zotino is <5e-11 FS rms (<1nV/rtHz on +-10V). Noise for this DAC before filtering will be more like 1e-9 FS RMS (2nV/rtHz on +-1V). So, to get the same stop-band noise, we will need something like 30dB of filtering...