Very rough, feel free to edit/tidy up! Discuss testing ideas in [Issue #117](https://github.com/m-labs/sinara/issues/117). Create new Issues as needed and apply Label [area:testing](https://github.com/m-labs/sinara/labels/area%3Atesting). 

Post results of tests here when completed (eventually, we'll move this into a documentation page)

# 0.1 (proto round 1)

## Thermal
* Check temperature of SFP in PCB_Sayma_AMC and PCB_Metlino operating at 10 Gbps. Discussed in #158. 

## Analog

* Phase noise of the various clocks/parts of the clock distribution network
   * related to #118 
* DAC + ADC SFDR & phase noise
* Temp dependence of output power/phase
* Return loss of all RF (inc. clock) inputs/outputs
* Do unterminated clock outputs from eRTM15 cause problems (see #78)?
* Crosstalk (intra DAC, inter DAC, intra ADC, inter ADC, ADC-DAC)
* DAC/ADC offset and its stability

## Digital bootstrap/testing

* AMC

  * JTAG
  * Flash
  * MiSoC, UART
  * DDR3
  * Ethernet
  * DRTIO Clock tree
  * Transcievers
  * DRTIO
  * (I2C)
  * (FMC)
  * (other DRTIO up/downlinks SFP/SATA)

* RTM

  * AUX FPGA config, clock, xcvr, TTL/SPI pass-through/DRTIO
  * SPI tree
  * DAC clock tree
  * DAC JESD
  * Analog mezzanine configuration

* RTM backplane
  * baikal test: RFB clock reflection due to unoccupied RTM slots #118