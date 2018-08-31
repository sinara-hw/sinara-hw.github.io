[Originally from OHWR](http://www.ohwr.org/projects/ed/wiki/Schematics_checklist)

# Usage
* use this as _your personal_ checklist for a specific review
* copy the source of this somewhere (issue or wiki page) for every schematic you review.
* clearly state:
  * who is reviewing
  * what is being reviewed
  * when done
* remove this section
* fill out check list
* when hitting issues/mistakes/problems/questions, open an issue and reference that issue

--

# Schematics design review checklist

## Create and study BOM, powerlist and netlist

- [ ] *Use as few different components as possible*. 
  - [ ] A single BOM line is costing roughly 100-200 CHF (ordering, putting roll on machine etc.) and you will save time for yourself (checking BOM, ordering) and will also have less chances of mounting the wrong components.
  - [ ] *Print the BOM*, check the resistor values used and see if you can remove some values by putting them in parallel or series (or actually taking existing values that are as good). The same for capacitors (cf. "SVEC": 9 C-types, 16 R-types).
  - [ ] Check if high precision or high power components are used (e.g. 0.1% or 0.5W) are needed.
  - [ ] Avoid through-hole components as they should be manually mounted.
- [ ] Print out the *power and ground list* for all ICs and check if they’re correctly connected.
- [ ] Print out the *netlist*, sort alphabetically and check for any inconsistencies (in naming, bus signals all used). This takes some time, but really can show non-obvious mistakes.
- [ ] For any newly created symbols, check the pin numbering.
  - [ ] CERN specific: check if only symbols created by the design office are used.

## Study schematics

- [ ] Buses: check if all bits are used.
- [ ] Check pin mapping for MIO in Xilinx SoC
- [ ] Differential signals: check if both _P and _N are used (and have really this polarity).
- [ ] Check each connection of ICs. Notably hard-wired settings of ICs (division/amplification factors, operating modes etc. Add a note).
- [ ] Check polarity of capacitors, notably on those connected to negative power supplies.
- [ ] Check correct polarity of diodes and LEDs.
- [ ] Check if enough decoupling for each IC.
- [ ] Check if LDOs have right capacitor values and types (ESR limitations)
- [ ] Check global decoupling of power supplies (large cap at point of generation or entry).
- [ ] Check protection circuits on the signals. Verify in detail where current flows through.
- [ ] Check if signal levels are compatible between outputs and inputs (LVTTL etc.).
- [ ] Check for any crosses on wires (showing no connection) and check connectivity of crossing wires (a dot should show connected).
- [ ] Check if there is a note about hard-wired settings of ICs (division/amplification factors, operating modes etc.).
- [ ] Calculate output voltage of DC/DC converters using formulas from datasheet and check if corresponds with note on schematic.
- [ ] Check if components are aligned to make the schematics look clear.
- [ ] Check consistency of naming and numbering of schematic pages.
- [ ] Check for testability: can all signals be tested on a production test system (e.g., without needing probes, calibration etc.).
- [ ] Check if all pages have a hardware version number, and license information on them somewhere prominent.
- [ ] Check if version or revision of a PCB can be accessed via gateware.
- [ ] Check gigabit lines Rx/Tx directions between transceiver and connector. Some standards like PCIe connectors define it in different way than i.e. SFP or MTCA.
- [ ] Check direction of other digital lines between CPU/FPGA and peripherials like RGMII. Note that some standards use unique naming convention, i.e. in REthernet PHY TX means input and RX means output while in MAC chip is opposite.
- [ ] Check placement of coupling capacitors on gigabit lines. Caps should be on TX side of the transmission line.
- [ ] All gigabit lines to SFPs and FMCs should be DC-coupled.
- [ ] Check if all LEDs have similar current (should be less than 5mA)

## FMC mezzanine cards

- [ ] An FMC mezzanine should have a specific EEPROM (24AA64T-I/MC).
- [ ] EEPROM: GA1 should connect to A0, GA0 should connect to A1 (Observation 5.22 "ANSI/VITA 57.1 spec").
- [ ] TDI and TDO are connected together if not used on the mezzanine.
- [ ] Have a note on the schematic about allowed Vadj level (e.g. most carriers on ohwr can provide only 2V5).
- [ ] Foresee decoupling capacitors near the FMC connector (allowing power pins to work as signal return too).
- [ ] Connect all mounting holes to ground (this is not in the specification, but is the best practice).
- [ ] Consider using a thermometer/unique ID IC (DS18B20U+) as is used on most OH FMC designs (this is not in the specification, but is the best practice).
- [ ] Check if FMC clock are in the same clock domain as signals (LAxxCC)

## Schematics conventions

- [ ] Name power P3V3, M5V0, GND, AGND etc.
- [ ] Power symbol for positive supply should point up and those for negative supplies should point down.
- [ ] Clock signals, add frequency in name (eg. CLK_100, CLK20_VCXO).
- [ ] Negative signal names: suffix _N (e.g. PB_RESET_N), do not use over-line that disappears in text files.
- [ ] Use same page size (e.g., A3) for all schematics pages.

## Documentation

- [ ] Check that each schematics page has on the same place the "CERN Open Hardware Licence: Copyright mycompany 2016. This documentation describes Open Hardware ..."
  - [ ] This text can be found in the 'howto' file at "CERN OHL version 1.2".
- [ ] Document all inputs and outputs on the schematics pages
  - [ ] voltage and current on external power connectors
  - [ ] voltage level and input impedance on coax inputs
  - [ ] voltage level and output impedance or drive level on outputs
  - [ ] make clear which connector type is used.