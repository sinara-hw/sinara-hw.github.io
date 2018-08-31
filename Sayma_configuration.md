## Sayma Configuration

### MMC
Module Management Controller is  [Open MCC](https://github.com/lnls-dig/openMMC) is used.
- Serial console: 115200, 8, n, 1 (4th of the four ports exposed by FTDI chip)
- Press front-panel button to trigger MMD to dump to serial console
- SCANSTA control is automatic - when you unplug RTM, MMC detects it and reconfigures SCANSTA.
- updating firmware on MMC
    - Install FlashMagic
    - Attach serial port
    - set LPC1776, 8MHz oscillator, select hex file and press start.

### Debugging
Sayma_AMC and Sayma_RTM have several RF debug ports. Use low-profile 90-deg adapters for debugging in chassis. 
* __U.FL__: U.FL to  SMA adapter like the L-COM CA-UFLSBQC20. 
* __SMP__: SMP to SMA adapter like CentricRF C574-086-12. 
* __clock__: 1.2 GHz differential clock LVPECL