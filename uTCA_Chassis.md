# µTCA chassis options for Sayma and Metlino

## Full 19" (9 U, 84 HP) chassis, with LLRF, up to 12 Sayma, 1 Metlino

Everything needed for up to 12 Sayma AMC+RTM, and Metlino+eRTM15. With LLRF backplane for clock distribution.

All from NAT:

| qty | NAT PN | description | comment |
| --- | ------------- | :-------------: | :-------------: |
| 1 | [NATIVE-R9](http://www.nateurope.com/manuals/native_r9_man_hw.pdf) | Rack | This is the only rack which currently supports a RF backplane. RF BPs are planned for more racks in future (work not funded/started yet). |
| 1 | NAT-PM-AC1000 | 1kW PSU | Cheaper, lower power-rating PSUs are also available, with similar specs. However, the price difference isn't that great. |
| 1 | NATIVE-LLRF | RF BP | Optionally used to distribute clocks. |
| 1 | NAT-MCH-Base12-GbE | MCH | It is mechanical support for Metlino, it also delivers power. It regulates temperature inside the crate, enables power supplies and manages power distribution. Includes a 12 port GbE switch for Port 0. Some day we will make our own, simplified version. |
| 1 | NAT-MCH-FP0D | Double width full-size front-panel for NAT-MCH-Base12-GbE | |
| 4 | NAMC-Filler FS-FP1D | Double-width full-size (6 HP, PM/MCH) filler + panel | Needed for proper air flow in the rack. Empty crate needs 6 of them (4 PM + 2 MCH) With one PM and MCH we need 4 |
| 5 | NAMC-Filler FS-RP1D | Double-width full-size (6 HP, rear PM/MCH/eRTM15) filler + panel | 5 in our case assuming that we we only use one eRTM15 |
| 12 - N | NAMC-Filler MS-FP1D | Single-width full-size (4 HP, AMC) filler + panel | 12 needed for an empty rack |
| 12 - N | NAMC-Filler MS-RP1D | Single-width full-size (4 HP, RTM) filler + panel | 12 needed for empty rack |

Where N <= 12 is the number of Saymas to be supported.

12 NAMC-MS-FP1D come for free with the rack.


## Small (5 U, 42 HP) chassis, up to 6 Sayma, 1 Metlino

No redundant power supplies. Only one MCH (but Sayma does not support more anyway). Currently no LLRF backplane available. Clock needs to be fed via SMA connector to each Sayma RTM.

| qty | NAT PN | description |
| --- | ------------- | :-------------: |
| 1 | [NATIVE-R5](http://www.nateurope.com/manuals/native_r5_man_hw.pdf) | Rack |
| 1 | NAT-PM-AC600 | 600 W PSU |
| 1 | NAT-MCH-Base12-GbE | MCH |
| 1 | NAT-MCH-FP0D | MCH Panel |
| 1 | NAMC-Filler FS-FP1D | Filler |
| 2 | NAMC-Filler FS-RP1D | Filler |
| 6 - N | NAMC-Filler MS-FP1D | Filler |
| 6 - N | NAMC-Filler MS-RP1D | Filler |

Where N <= 6 is the number of Saymas to be supported.

## Sinara components for both chassis

| qty | Sinara component | description |
| --- | --- | --- |
| 1 | Baikal | eRTM15 clock fan-out, only when using the LLRF backplane clock distribution in NATIVE-R9 |
| 1 | Mordovia | MCH tongue 2 interposer |
| 1 | Metlino | MCH tongue 3 and 4 |
| 1 | Metlino front panel | replaces NAT-MCH-FP1D |
| N | Sayma AMC | |
| N | Sayma RTM | |
| 4N | Allaki/BaseMod | Sayma AMC analog frontend, 2 channels |


# Single-unit uTCA.4 chassis

Compact, low-cost rack for a single AMC + RTM, connected to an external MCH via DRTIO.
Brief specification:
- dimensions: width 10U, length = RTM+AMC, heigth: tbd
- supply: 12V external with DIN jack, there are plenty of suitable COTS AC/DC supplies
- Power switch

Interfaces:
- 4 SFPs for fat pipe and 2 SFPs for Port0 and Port 1.
- 2x RJ45 would be either RS232 ( routed to LVDS signals) or LVDS. They are mutually exclusive so using resistor placement variant we can have one or another.
- 1x RJ45 with management Ethernet port implementing IPMI.
- LPC1764FBD100 for management. Can be not mounted for completely passive operation
- JTAG header
- 2x SMA with baluns routed to TCLKA and TCLKB
- 1x SMA routed to clock mux which selects between SMA or 100MHz internal clock. Connected to FCLK
- 2x eSATA (port 2, port 3)
- Small 4x10 LCD display connected to AMC I2C.
- The design will be based on http://creotech.pl/en/produkt/dual-amc-box-2/ with reduced functionality, weight and cost. Mechanically it would look similar, only height will be reduced by almost 50%

AMC box render:
![](https://user-images.githubusercontent.com/4325054/33516408-a32756f6-d772-11e7-8753-f1995c0d94cd.jpg)

Real photo
![](https://github.com/m-labs/sinara/blob/master/Drawings/AMC_box_front.jpg)
