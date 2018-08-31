This page contains hardware projects that haven't yet become professionally-designed parts of Sinara yet. These projects range from ideas waiting for further specification/funding to well-advanced physicist-designed projects that haven't been professionally developed/tested yet.

# Locker

- PDH lock
- **Form factor**: 2 channels on a Eurocard?
- 2 channel DDS for modulation + demodulation (allows digital phase shift)
- RF out path: filter, digital step attenuator, pre-amp (copy from Urukul/BaseMod)
- Input path: mixer, active low pass filter/output buffer. Design for low latency, so this can be used for locks up to a few MHz (utilize max bandwidth of diode laser)
- Cheap FPGA + ethernet to program DDS etc

# Stabilizer

- General purpose lock box
- 2 or 4 channels on a Eurocard?
- 16-bit ADC + DAC with simple filters for each channel. No PGIA etc (assume AFE is on a separate board)
- >1MSPS. 10MSPS? Ideally, aim for a few MHz of loop BW
- ADC could potentially be the nice LTC 4 channel 5MSPS LVDS.
- Cheap Artix FPGA for loop filter, communication over ethernet
- Maybe have an option so that the input can either be an analog voltage or a digital signal (frequency). Ideally, set things up so that the input is routed both to a TTL-LVDS translator/comparator (for the digital path) and to the ADC. Otherwise, have a solder jumper to switch between the two paths.

# Ingester
- Fast uTCA ADC
- >=100MSPS. 1GSPS?
- 8 channels?

# Blaster
- 12 GSPS SAWG RTM card for direct microwave synthesis for sc qubits ([issue #183](https://github.com/m-labs/sinara/issues/183))
- Details [here](Blaster)

# Thermometer: Temperature Logger

- Non-real time (?)
- Eurocard size
- Controlled via ethernet: RJ45 jack on front panel; microprocessor (same rust/smoltcp stack as IonPack?); simple, SCPI-like text-based interface
- Same power connector/power supply as Kasli (connector on front panel)
- Same EEPROM as EEMs for serial number, etc
- Maybe combine with temperature controller board
- what kind of sensor: 10k thermistor? PT100? DS1820
- What accuracy/stability?
- 4+ inputs

# Laser diagnostics

- Port Oxford WaND to Kasli. (Old version here https://github.com/ljstephenson/wand/)
- Multi channel laser diagnostics 
- Multiple lasers connected via a multi-mode fiberised optical switch (switch controlled via ethernet by Kasli)
- Digitises Optical Spectrum Analyser outputs (OSA)
- Logs wavelength on wavemeter
- Simple feedback loops to lock laser to wavemeter
- Nice GUI
- Detect lasers starting to go multi-mode?

# Coil current stabilisation loop

- Non-real time
- Eurocard size
- Controlled via ethernet: RJ45 jack on front panel; microprocessor (same rust/smoltcp stack as IonPack?); simple, SCPI-like text-based interface
- Same power connector/power supply as Kasli (connector on front panel)
- Same EEPROM as EEMs for serial number, etc
- External sensor (e.g. [LEM IT-400S ULTRASTAB](http://www.lem.com/docs/products/it_400-s_ultrastab.pdf)) used to measure current flowing through a coil (typically 50A-400A)
- Feedback loop controls current in small bypass transistor to remove drift/noise in the coil current 
- Complex loop-filter implemented in DSP to give maximum loop bandwidth: 2 zero-frequency poles to remove low-frequency noise; notch filter to remove flux-gate noise; compensation for power supply output impedance/coil inductance.
- Bypass transistor also used for feed-forwards to modulate coil current 50Hz/60Hz and harmonics to cancel ambient magnetic field noise in lab
- Version of Oxford high-current stabilisation loop, but do loop filter with DSP.
- Link to paper when published

# Pylon: HV piezo driver

- Intended use-cases: ?
- **Should this be an EEM to provide real-time control**? No. Let's make it ethernet and PoE. 4 outputs on 4HP.
- Based on https://github.com/JQIamo/hv-piezo-driver and https://arxiv.org/abs/1609.03607
- 0-250V output in present design, higher voltages with minor modification.
- < 100uV RMS (1 Hz - 100kHz)
- All digital, no external analog input
- Sensible output current limit to avoid excessive power dissipation (means this design will have limited BW when driving large signals into large capacitive loads). 

Possible improvements:
- Existing design has onboard MCU which handles frontpanel interactions (pushbutton rotary encoder; SPDT switch; LCD display). I2C exposed on backplane. Probably remove all of this and just provide an ethernet interface.
- remove MCU and control DAC directly over SPI (AD5663R; 16bit) or swap for better DAC.
- Add onboard fast DAC to drive analog modulation input
- Add more channels (how many? what connectors to use?)

# Current controller

Low-noise current controller for (low-power) laser diodes. This is an iteration of the Libbrecht-Hall design, via Dallan Durfee (https://arxiv.org/abs/0805.0015).

**Should this also be an EEM?** (Kasli-based EEM laser controller? when combined with TEC and PZT units?)

- Based on https://github.com/jqiamo/current-controller/tree/v2-updates (branch needs to be rolled back into master)
- Current feed-forward from [piezo driver](#hv-piezo-driver)
- Existing MOSFET supports 0-180mA; modifications might be necessary depending on diode voltage. Overlapping footprints for higher current MOSFETS (untested, but on the list of things to do).
- Control via ethernet and/or EEM connector?
- ~ 10MHz analog modulation bandwidth summed onto output
- cf https://arxiv.org/abs/1604.00374 (reduce noise when operating near current rail)
- low-frequency 1/f noise from voltage reference temperature instability -> use different reference.