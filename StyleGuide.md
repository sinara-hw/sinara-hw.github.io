# The Wiki

The Wiki is the a main source of documentation for the Sinara ecosystem, explaining what the hardware can do and how it was designed to be used. It is mainly maintained by the community, and needs help keeping it up to date.

## Board-level pages

There is a page for each EEM/AMC+RTM. These pages should begin with an overview, containing:
- Brief description of what the board does and how it is intended to be used
- Photograph 
- Link to detailed PDF documentation
- Link to schematic and other files on GitHub
- Link to any relevant Artiq pages (e.g. drivers)

This overview should be followed by a bullet-pointed specification, including things like:
- Current hardware version/status
- Suppliers and rough cost
- Power consumption
- Required minimum air flow (only for higher power EEMs)
- Size
- Number of EEM connectors

Finally, post links to relevant issues, measurement data/figures, advice, etc.

# GitHub releases and file management

## Release versioning

* **v1.0rc1**: first design/schematics review before the first prototype
* **v1.0rc2**, **v1.0rc3**, ...: subsequent design/schematics reviews
* **v1.0**: first prototype
* **v1.1**: first "production" run with minor tweaks
* **v2.0**: second (sometimes major) iteration of the design, potentially denoting only a prototype run.
* **v2.1**, **v2.2** etc would be production runs including minor tweaks.

The git commit corresponding to each release should be tagged with a name like *Kasli/v1.0rc1*, allowing the source files for that release to be easily located.

## File management

The repository is for "source files" only, so please don't add "output files", such as schematic PDFs, gerbers, drill, XY, BOM, renderings, .cce files, etc. into the repository. These files should only be uploaded as part of a release and are uploaded to the [releases](https://github.com/m-labs/sinara/releases) that are generated from the [tags](https://github.com/m-labs/sinara/tags). Design reviews etc are treated as "release candidate"/rc releases using the same system.

# EEM Front Panels

* Refer to the various standards.
* Use proper mounting hardware: supply and mount all parts (screws, handles, washers, angles, panels), handles of correct width, correct PCB angle brackets, sunk/pan head screws were mandated, use correct type and length of screws.
* Panels are 3U high and multiples of 4HP wide and designed and viewed in that orientation (panel retaining screws are at the bottom and at the top).
* Ensure that the panel extraction handle does not interfere with a cable/connector or LEDs and that it does not impede ergonomics of mounting/unmounting.
* The reference panel for all aspects of size, type, orientation, and position of font, label, logo is [**Urukul**](https://github.com/m-labs/sinara/blob/master/ARTIQ_ALTIUM/PANELS/Project%20Outputs%20for%20PANELS/PANELS.PDF). Use the mono-space font from Altium PCBs. Use font size, line thickness as in the reference design.
* Material
  * Panel material should be hard aluminum of 2.5 mm thickness.
  * Panels coloring should be black ink on silver (plain transparent anodized Aluminum).
  * Edges don't need to be anodized.
  * Markings printed and cut on foil on anodized Aluminum are acceptable for prototyping rounds. Otherwise use properly milled and ink-filled processes.
  * Make sure that borders around cutouts (e.g. 4xRJ45) are minimum width to provide mechanical stability.
* Connector Cutouts
  * Enable the use of isolating washers for SMA connectors by sizing the cutout correctly.
  * Use isolated BNC connectors where possible.
  * Use sufficient length SMA connectors. Account for plastic washers on both
    sides of the panel. Verify panel position.
  * Use through-hole angle-mounted SMA connectors.
  * Ensure that the mounting hardware of the connectors (washers, screws) does not overlap with text on the panel.
  * Supply all mounting hardware.
  * Ensure that the mechanical stresses (during mounting or operation) are handled by the panel and not by the PCB.
  * When assembling, tighten the screws on the angle brackets **after** tightening the screws on the connectors.
* Logo
  * Put the ARTIQ logo on the front panel. Don't outline it. Use properly filled plotting. Use the same position and size as for the reference panel.
  * Place the ARTIQ logo on the front panel at the same location in the top left independent of the width of the panel. Place it between the retaining screw of the panel and the sunk attachment screw of the PCB angle bracket.
  * No logos (no company logos or names) other than the ARTIQ logo or the yet-to-be-designed Sinara logo.
* Board name, description
  * Place a label with the board name (`Urukul`) and a minimal description (`4x 1GS/s DDS`) right below the upper PCB angle bracket sunk mounting screw. Center it horizontally on the panel. Use proper English capitalization: `Urukul 4x 1GS/s DDS`.
* Channels
  * Channels are numbered starting from zero.
  * First channel should be at the top left, second channel top right, etc:
    Row-major with the origin at the top left.
  * Call the channels `IOx`, `INx`, `OUTx` or `RFx` where `x` is the channel number.
  * Place direction, status, fault, termination etc indicators as close to the channel connector as possible.
  * Put a box around the channel and its indicators if the association is not immediately obvious.
  * Put a box around channel groups (e.g. I/O direction for groups of four)
* Labels
  * Label all indicators, connectors. Use `UPPER CASE`.
  * Place labels below the item they refer to where possible
  * Place board status indicators at the bottom of the panel just above the
    handle.
* Revision
  * At the very bottom of the panel (just right of the bottom left panel retaining screw, independent of the width of the panel) place the revision number as `vX.Y` where `X` and `Y` are major and minor version numbers.
