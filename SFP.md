Sinara Core Devices (Kasli, Sayma, Metlino) use SFP modules for several purposes.
- Connection from Core Device to ARTIQ Master via Ethernet switch.
- Synchronization of Core Devices via ARTIQ DRTIO

# Core Device to Ethernet Switch 
The most basic use of SFP is to connect a core device to an Master PC via an Ethernet hub. The following parts are sufficient.
 
- fiber: SM 9/125 OS2 single-mode simplex fiber patch cable with connectors LC/UPC-LC/UPC (not angle polished) (eg [sf.com p/n SM-LCU-LCU-SX-FS-2M-PVC](https://www.fs.com/products/40435.html))
- 1000Base-X SFP transceiver A: SFP-GE-BX (Tx at 1310 nm Rx at 1490 nm) (eg [sf.com p/n 20184](https://www.fs.com/products/20184.html))
- 1000Base-X SFP transceiver B: SFP-GE-BX (Tx at 1490 nm Rx at 1310 nm) (eg [sf.com p/n 29895](https://www.fs.com/products/29895.html))
- 1000Base-X SFP to RJ45 (twisted pair copper) Gigabit Ethernet Media Converter (eg [sf.com p/n 17237](https://www.fs.com/products/17237.html)) 

Here, a single mode optical fiber is used for bi-directional communication using two-channel wavelength division multiplexing. The SFP modules at either end of the fiber differ based on the laser diode color and grating configuration. 

## Other configurations
A variety of other SFP components also work with Sayma hardware. 
- 1000BASE-T twisted-pair copper GBIC: core device -- SFP-GB-GE-T --- RJ45 copper --- SFP-GB-GE-T --- switch (eg sf.com p/n 34976)
- Direct attach cable (twinax), and SFP slot in upstream switch
- Pair of 1000BASE-LX modules plus LC-LC duplex fiber and SFP slot in switch

## Parts that do not work
- SFP-GE-T 10/100/1000BASE-T SFP