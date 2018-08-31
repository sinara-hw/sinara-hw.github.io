SATA to SFP connector that can be assembled as straight or cross-over. Power is supplied via micro USB (+5 V). 

LEDs:
- LD1 is on if SFP module is absent (MOD_DEF0)
- LD2 is on if SFP is indicating transmitter fault (TX_FAULT) 
- LD3 is on if SFP module is a) disconnected b) optical power is too low (LOS)

DIP switch:
- sw1 = 1 disables SFP optical output (TX_DIS)
- sw2 = 1 grounds data for serial ID interface (MOD-DEF2)
- sw3 = 1 grounds clock for serial ID interface (MOD-DEF1)
- sw4 = 1 selects reduced bandwidth (RateSelect)

https://github.com/m-labs/sinara/tree/master/ARTIQ_ALTIUM/PCB_SATA_SFP

![image](https://user-images.githubusercontent.com/4325054/34392716-41804f1c-eb4e-11e7-8249-c6a483de3e7d.png)