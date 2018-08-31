# Metlino uTCA MCH

Metlino is a microTCA carrier hub (MCH) optimized for use with Sinara hardware. It serves as the rack master, controlling uTCA periherals, such as the [Sayma AWG](Sayma), in real time by sending Artiq DRTIO commands over the rack backplane. It can also control additional Artiq peripherals via the SFP and VHDCI connectors on its front panel.

Metlino can be as either the ARTIQ master, or as an ARTIQ DRTIO slave connected to the master via DRTIO. In master mode, it receives commands from the host PC via ethernet, in slave mode, it receives commands from the Artiq master via SFP.

Metlino provides 64 LVDS IOs, accessible through 2 VHDCI connectors, as well as ? FMCs. The VHDCIs are compatible with the [VHDCI carrier](VHDCICarrier) and [Eurocard extension modules](EEMs).

The design files are located in [ARTIQ_EE/PCB_Metlino](https://github.com/m-labs/sinara/tree/master/ARTIQ_EE/PCB_Metlino), the schematic is [here](https://github.com/m-labs/sinara/blob/master/ARTIQ_EE/Metlino_MCH.pdf).

## Specification
* FPGA is Kintex UltraScale KU040 speed grade -1 (p/n XCKU040-1FFVA1156C) -- motivation for this FPGA choice is [here](https://github.com/m-labs/sinara/wiki/artiq_hardware#recommendation)
* Connectors
  - ? SPFs
  - 2 VHDCIs providing low-latency digital outputs, and control of [EEMs](EEM)
* RAM
* Etc

## Transceiver/connector usage

* SFP123: all DRTIO downstream
* FABRICD: all DRTIO downstream
* FABRICE: not used
* FMC:
  * DP0123: (FMC 4xSFP) DRTIO downstream
  * LA: FMC DIO32: TTL IO

## MCH Stack

![](https://github.com/m-labs/sinara/blob/master/Drawings/mch_stack_mordovia_explanation.png)

The standard MicroTCA backplane has a many-to-one topology with a MicroTCA Carrier Hub (MCH) that sits at the center. The MCH connects to the backplane via four edge-connect sockets (tongues). Metlino occupies MCH tongues 3 & 4. For the ARTIQ application a simple PCB fills tongue slot 2 [Mordovia](uTCAMisc) and the NAT [NAT-MCH-Base12-GbE](http://www.nateurope.com/products/NAT-MCH.html) fills tongue 1. All three boards mount behind a shared front-panel.

The repository contains design files [ARTIQ_ALTIUM/PCB_MCH_mordovia](https://github.com/m-labs/sinara/tree/master/ARTIQ_ALTIUM/PCB_MCH_mordovia) and [schematics](https://github.com/m-labs/sinara/blob/master/ARTIQ_ALTIUM/PCB_MCH_mordovia/MCH_mordovia.PDF) for Mordovia.

## Clocking

In master mode, Metlino receives its clock via a SMA on its front panel. In slave mode, Metlino is also capable of recovering a clock from the DRTIO communication link. This recovered clock is filtered using an Si? chip.
