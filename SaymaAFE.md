# RF Front-End Mezzanines

Mezzanines providing analogue front-ends (AFEs) for the ADCs and DACs on Sayma. 

# Available AFEs

## TestMod

Simple mezzanine designed for thermal and connectivity testing, and to serve as a template for other mezzanine designs.

To do: add image and description of functionality.

Design files are [here](https://github.com/m-labs/sinara/tree/master/ARTIQ_ALTIUM/PCB_mezzanine_analog_template), the schematic is [here](https://github.com/m-labs/sinara/blob/master/ARTIQ_ALTIUM/PCB_mezzanine_analog_template/AFE_mezzanine.PDF).

-----

## BaseMod

BaseMod is a base-band input/output mezzanine. Design files are [here](https://github.com/m-labs/sinara/tree/master/ARTIQ_ALTIUM/PCB_mezzanine_analog_allaki), the schematic is [here](https://github.com/m-labs/sinara/blob/master/ARTIQ_ALTIUM/PCB_mezzanine_analog_allaki/Project%20Outputs%20for%20allaki_mezzanine/allaki_mezzanine.PDF).

NB: 12/2017 Allaki was [renamed](https://github.com/m-labs/sinara/issues/396) BaseMod.

To do: add image

### Outputs

BaseMod provides two independent RF outputs, featuring:

- **Bandwidth**: 10MHz - 4GHz (upper frequency is limited by several different components)
- **Max output power**: ?dBm (limited by ?).
- **Output filters**: either 3 Mini-Circuits FV1206 series filters, or a user-definable discrete 9-pole discrete-element filter using 0402 components.
- **Low phase noise amplifier**: Mini-Circuits ERA-4XSM+); 14.2dBm gain at 1GHz.
- **Digitally programmable attenuator**: HMC542BLP4E; 0dB to 31.dB in 0.5dB steps; controllable in real-time.
- **Fast, high-isolation RF switch**: HMC349LP4C; 67dB isolation at 1GHz; controllable in  with real-time control.
- **Power detector**: AD8363ACPZ on switch "off" port for monitoring and power levelling.
- **Optional isolation of output grounds**: to avoid ground loops, achieved by fitting capacitors and washers.

### Inputs

BaseMod provides two independent inputs, each of which can be configured (component placement) as:

1. Direct feed to ADC via ADA4927-1 buffer for maximum bandwidth

2. Low-noise programmable gain instrumentation amplifier (AD8253) front-end
  - **Bandwidth**: DC-300kHz
  - **Input ranges**: ±0.1V, ±1V, ±10V
  - **Fully differential inputs**: 100k between each input signal and ground and the circuit ground
  - **Filters**: Common-mode and differential mode filtering of RF interference for optimum DC precision
  - **Input protection**: diodes between each input and the supply rails for maximum ruggedness

* Supports both high-speed input directly coupled into a high-speed pre-amp, and low-frequency inputs using a variable-gain instrumentation amplifier (choice by component selection). Pull details from [#81](https://github.com/m-labs/sinara/issues/81)
* Instrumentation amp: gain, filters, etc.

## MixMod

MixMod is an up-converting mezzanine, using an analogue IQ mixer to mix the input and output RF signals with a LO supplied by Sayma.

The LO provided by Sayma should be a 3V3 PECL square-wave.

### Outputs

MixMod provides a single RF output between 2.5GHz and 3.5GHz, produced by mixing two DAC channels with a LO supplied by Sayma. Other than the IQ mixer, the output signal-chain is identical to BaseMod. 



### Inputs

MixMod's two inputs can either be operated in baseband or downconversion mode (selectable by component choice). In baseband mode, the inputs function identically to BaseMod's. In downconversion mode, a single SMA input feeds the RF port on an IQ mixer to produce a pair of baseband signals, which then feed the two signal chains.

# General Specification

## Mechanical

- Board size
- Mounting holes
- SMA locations and pns
- Connectors

## Electrical
* Suggest [ADL5375](http://www.analog.com/en/products/rf-microwave/iq-modulators-demodulators/iq-modulators/adl5375.html) IQ modulator.  Good intrinsic carrier/sideband rejection, relatively low temp coefficients, sufficient IF bandwidth, good I/Q linearity.  This is the chip used in the NIST Magtrap drive system.
* Signal levels etc
