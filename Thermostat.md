# The repository and wiki were moved here: https://github.com/sinara-hw/Thermostat/wiki

Thermostat is a planned 2-channel temperature controller EEM based on the Thorlabs [MTD415T](https://www.thorlabs.com/thorproduct.cfm?partnumber=MTD415T), capable of driving 6W into a TEC or resistive heater. Discussion of this EEM is [here](https://github.com/m-labs/sinara/issues/461). 

# Overview
- **Channel count**: 2
- **Sensor**: 10k NTC thermistor
- **Load (heater/TEC) drive**: up to 6W (+-1.5A with 4V compliance, 2.66 Ohm load for optimal performance)
- **Output connectors**: Sensor and load connect via either D9 connectors (1 connector per channel) on the front panel or via internal 100mil pin-header.
- **Programming interface**: UART (1 per channel) accessible via either an RJ45 connector on the front panel or via an internal EEM connector.
- **Power supply**: +12V DC (?A max) supplied either by a front-panel barrel connector or via EEM connector.

# Comments
- For the LVDS interface, just or the Tx lines from the Rj45 and EEM connectors.
- Idea is to keep this board as simple as possible, simply consists of: the thorlabs IC; a 5V SMPS; LVDS interface; and, the connectors. Same form factor as the DIO EEMs.
- 1 LED per channel to indicate if the temperature is in range (connects to the STATUS pin of the Thorlabs IC). Also, have a single power LED.
- 0R resistors on the thorlabs IC enable pins to allow them to be disabled for debugging purposes.
- Add header/tespoints for standard UART to USB interface (useful for testing). Should be 4-pin with GND, 5V, Tx, Rx
- add unique ID chip for TM4C and identification purposes.