Originally from [VolerSystems](http://volersystems.com/v-2010/91-pcb-layout-checklist/) compiled with [EPD](http://www.electronic-products-design.com/geek-area/electronics/pcb-design/general-pcb-design/a-good-pcb-design-checklist)

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

# PCB design review checklist

## Part Placement

 - [ ]   clearance for IC extraction tools
 - [ ]   clearance for BGA inspection
 - [ ]   clearance for BGA heat sink assembly
 - [ ]   all polarized components checked
 - [ ]   check the orientation of all connectors
 - [ ]   minimum component body spacing
 - [ ]   is there sufficient distributed cap on the power rails? One big cap in the corner isn't as good as four smaller caps spread around the board.
 - [ ]   verify that all series terminators are located near the source
 - [ ]   I/O drivers near where their signals leave the board
 - [ ]   PCB has ground turrets, power rail test points, and test points for important signals, all labeled
 - [ ]   EMI and RFI filtering (TVS, CMC) as close as possible to exit and entry points in shielded areas
 - [ ]   EMI ground via stitching at the PCB edges
 - [ ]   potentiometers should increase controlled quantity clockwise
 - [ ]   mounting holes electrically isolated or not
 - [ ]   proper mounting hole clearance for hardware
 - [ ]   SMD pad shapes checked
 - [ ]   tooling holes for automated assembly
 - [ ]   sufficient clearance for socketed ICs
 - [ ]   diodes at output of voltage regulators -- prevents transient reverse biasing of dual-supply ICs (discussed in [#216](https://github.com/m-labs/sinara/issues/216))

## Routing

- [ ]   digital and analog signal commons joined at only one point
- [ ]   check for traces running under noisy or sensitive components
- [ ]   no vias under metal-film resistors and similar poorly insulated parts
- [ ]   check for traces which may be susceptible to solder bridging
- [ ]   check for dead-end traces (antennas), unless used on purpose
- [ ]   ensure schematic software did / did not separate Vcc from Vdd, Vss from GND as needed
- [ ]   provide multiple vias for high current and/or low impedance traces
- [ ]   component and trace keepout areas observed
- [ ]   ground planes where possible
- [ ]   are the traces wide enough? Especially power traces? Make the traces as large as reasonable, unless you have specific reason not to.
- [ ]   use power planes where possible, especially under processors or chips with multiple power pins
- [ ]   are the thermal reliefs as you intended? High-current components get no thermal relief, but also no solder mask. Otherwise it will be very difficult to solder. Make sure there's plenty of exposed copper on both sides of the board for those components. Everything else gets standard thermal reliefs, 10 mil or so is probably fine spoke width.
- [ ]   are all isolation barriers wide enough? Are all high voltage clearances in place? Look particularly for traces under heat sinks tied to high voltage through a transistor tab. Also look for clearances to any mounting holes.
- [ ]   are there nets that need their length equalised (e.g. fast differential connections such as Ethernet)?
- [ ]   check all surface mount pads have tracks that come out of the end, not the side (i.e. no links between adjacent IC pads that will look like a short during inspection).
- [ ]   are there components that need copper plane heatsinking (voltage regulators, mosfets etc)? Are there enough vias to internal planes?
- [ ]   add test points for important buses and connections to tight SMD chips so its easy to attach a wire or scope probe.
- [ ]   ensure all high speed signal traces run over their own ground / power planes. Do not allow say a digital signal to travel over the analog plane unless it is going to a device in that area and in which case follow the devices digital ground trace to minimise the loop and therefore noise.
- [ ] if there are any slots or gaps in the Gnd / Power planes ensure no high speed signals run over them (to avoid the return path having to loop round, creating EMI problems).
- [ ] differential pair tracks are as close together as possible, or spaced based on impedance calculation?
- [ ] is copper balancing used?
- [ ] verify that all pads are unmasked on solde rmask layer
- [ ] verify that all vias are masked/unmasked on solder mask layer

## Dimensions 

- [ ]  hole diameter on drawing are finished sizes, after plating.
- [ ]  finished hole sizes are >=5 mils larger than lead
- [ ]  silkscreen legend text weight >=6 mils
- [ ]  pads >=0.1mm larger than finished hole sizes
- [ ]  components >=0.2″ from edge of PCB
- [ ]  test pads 200 mils from edge of board
- [ ]    traces >= 20 mils from edge of PCB
- [ ]    thru-hole drill tolerance noted
- [ ]    thru-hole route tolerance noted
- [ ]    thru-hole silkscreen legend tolerance noted
- [ ]    trace width sufficient for current carried
- [ ]    sufficient clearance for high voltage traces


## Silk Screen

- [ ]  no silkscreen legend text over vias (if vias not soldermasked) or holes
- [ ]  all legend text reads in one or two directions
- [ ]  company logo in silkscreen legend
- [ ]  copyright notice on PCB
- [ ]  date code on PCB
- [ ]  PCB part number on PCB
- [ ]  assembly part number on PCB
- [ ]  PCB revision on silkscreen legend
- [ ]  assembly revision blank on silkscreen legend
- [ ]  serial number blank on silkscreen legend
- [ ]  all silkscreen text located to be readable when the board is populated
- [ ]  all ICs have pin one clearly marked, visible even when chip is installed
- [ ]  high pin count ICs and connectors have corner pins numbered for ease of location
- [ ]  silk screen tick marks for every 5th or 10th pin on high pin count ICs and connectors
- [ ]  is the silkscreen correct, showing reference designators, not values? Check the actual exported gerber.
- [ ]  are all user terminals marked with function, + -, other relevant information?
- [ ]  are all jumpers, connectors etc labelled on the silkscreen?

## Documentation

- [ ] Create board outline on a mechanical layer
- [ ] Add fiducial marks for the pick and place machine on both sides, at least 2 different marks on each side
- [ ] Add stackup information, Layer 1 or drill layer is the best place.

## Other

- [ ]    CAD design rule checking must be turned on
- [ ]    Are there any design rule errors you can't explain
- [ ]    high frequency circuitry precautions observed
- [ ]    extra connector and IC pins accessible on prototype boards, just in case
- [ ]    check hole diameters for odd components: rectangular pins, spring pins
- [ ]    solder mask does or does not cover vias
- [ ]    no acute inside angles in foil
- [ ]    soldermask swell checked
- [ ]    manual netlist check
- [ ]    check netlist for nodes with only one connection
- [ ]    drill origin is a tooling hole
- [ ]    PCB thickness, material, copper weight noted
- [ ]    thermal reliefs for internal power layers, SMD pads and THT pads
- [ ]    no thermal reliefs for vias
- [ ]    solder paste mask openings are proper size
- [ ]    blind and buried vias allowed on multilayer PCB
- [ ]    PCB layout panelized correctly
- [ ]    high frequency crystal cases should be flush to the PCB and grounded
- [ ]    check all the layers. Sometimes I've left the solder mask layer turned off, only to find that there was some odd shape on it that I'd placed by accident
- [ ]   do a final design rule check even after cosmetic changes
