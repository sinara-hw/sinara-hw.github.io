Recent repository and board documentation was moved to https://github.com/sinara-foundation/Zotino/wiki
This wiki is not foreseen for update.

Zotino is a  32-channel, 16-bit DAC EEM with an update rate of 1MSPS (divided between the channels). It was designed for low noise and good stability.

Artiq docs/drivers link will be added once they are written!

![Zotino DAC PCB](https://github.com/m-labs/sinara/blob/master/Drawings/3U%20DAC%20photo%20top.jpg)

## Overview

- **Current hardware revision**: Rev 1.1 (first prototype)
- **Cost**: €500 (estimate)
- **Width**: 4HP
- **Channel count**: 32
- **Resolution**: 16-bit
- **Update rate**: 1MSPS, which may be divided arbitrarily between the channels
- **Analogue bandwidth**: 3rd-order Butterworth response with 75kHz cut-off; **?V/s slew-rate**
- **Output voltage**: ±10V
- **Output impedance**: 470Ohm in parallel with 2.2nF
- **DAC**: [AD5372BCPZ](https://www.analog.com/media/en/technical-documentation/data-sheets/AD5372_5373.pdf)
- **EEM connectors**: power and digital communication supplied by a single EEM connector.
- **Power consumption**: 3W without load, 8.7W with max load on all channels.

## Measurements and simulations

Temperature stability:
To do, but include self-heating. Worst-case OpAmp self-heating is about 25C. At 0.2ppm/C, this is 4ppm, which is fine!

**WIP -- will complete when measurements are made! **
- noise data...
- Add image of transfer function from schematics
- Add image of noise spectrum
- Add images of any measurements

# Accessories

* Zotino connects the 32 channels to both (a) a HD68 connector on its front panel and (b) to four IDC connectors on the board.
* HD68-to-HD68 cables are available from various sources.
* At the remote end, the HD68 connection can be broken out to four IDC connectors using [HD68-IDC](HD68-IDC).
* Each IDC connection with 8 channels (either directly from Zotino or from the HD68-IDC board) can be broken out to BNC using [BNC-IDC](BNC-IDC). That board can be placed in the same crate as Zotino or remotely together with HD68-IDC.