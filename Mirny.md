# Mirny microwave synthesiser extension

Mirny is a low-cost PLL/VCO-based microwave frequency synthesiser, designed for non-critical applications such as driving AOMs/EOMs.

Like the [Urukul DDS Synthesiser](Urukul) but with a VCO/PLL as the synthesizer and options for frequency double/tripler.


There are a couple of things that make Mirny different from Urukul:

* Frequency changes are not agile or have high timing resolution.
* RF switch changes or attenuator changes still benefit from high timing resolution through the EEM connector.
* The output frequency range should be much wider (up to 15 GHz) but doesn't need to be that wide-band.
* There are a couple designs that use the usual ADI/HMC any-frequency synthesizers. On the analog side, they simply solder different frontends that extend the frequency range to what's needed (doubling of tripling the typical 30-6000 MHz range). And those designs work well.
* The analog microwave PCBs for doubling and tripling, amplification, switching are more expensive and can be designed separately. They usually use castellation to connect them. And they have some simple means (2 pins pulled up/down by the frontend) of identifying the analog frontend PCB type.
* If at all possible, we should also think about running this without an EEM connection. Ethernet (maybe with POE). Or have a way to extend just the I2C tree from Kasli and 12V without occupying more EEM slots.

Status: idea. not funded.

## Specification

* Four channels per board if possible, two otherwise.
* No requirement for deterministic phase control or sub kHz resolution.
* To be used with [external power amp](RFPA) if required/desired.
* SPI plus a couple TTL/CS for attenuators/RF switches. If needed with a SPI
  based decoder, e.g.
  [PCA9502 8-bit I/O
  expander with I2C-bus/SPI interface](http://www.nxp.com/documents/data_sheet/PCA9502.pdf) or similar.
* Synthesizer ~40 MHz to ~4 GHz: e.g. [ADF4351](http://www.analog.com/media/en/technical-documentation/data-sheets/ADF4351.pdf) (like the [SynthNV](https://windfreaktech.com/product/rf-signal-generator-and-power-detector/)) or [HMC833](http://www.analog.com/media/en/technical-documentation/data-sheets/hmc833.pdf) (apparently a convenient superset of the ADF4351).
* Frequency reference from an internal few ppm-accurate Quartz.
* Include the usual chain of (similar to Sayma AFE Allaki digital output):
  * user-mountable filters
  * pre-amp
  * attenuators
  * rf switch
  * maybe: user-mountable frequency doubler (to 8/12 GHz) or tripler/quadrupler (to 16/18 GHz)
