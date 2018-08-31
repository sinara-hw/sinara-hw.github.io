- Discussion of EEM v2 is in [Issue 323](https://github.com/m-labs/sinara/issues/323). 

- Discussion of adapter for testing with Kasli is in [Issue 351](https://github.com/m-labs/sinara/issues/351).

- Discussion of putting active electronics on EEM backplane is is [Issue 233](https://github.com/m-labs/sinara/issues/233)


# Backplane

Following is a summary of a proposed backplane. Note that presently there is no officially supported EEM backplane (only the EEM Connectors). 

 * [Backplane design discussion, issue #129](https://github.com/m-labs/sinara/issues/129)
 * [Second backplane discussion, issue #168](https://github.com/m-labs/sinara/issues/168)

The 96 position DIN 41612 connector from Kasli should be used to supply
backplane-compatible EEMs or a breakout board for more EEM connectors.
Supporting the backplane from an EEM is optional.
Depending on electrical simplicity an EEM could opt to support an EEM Connector interface _and_
backplane signaling as a runtime alternative, or as a fixed design choice.

The equivalent of four EEMs is supplied from Kasli through the backplane.
Whether these four backplane EEMs are in addition to the eight EEM Connectors s or mutually exclusive with them remains TBD. The backplane is passive.

  * 1 pin: 3.3 V management power
  * 2 pins: 12 V
  * 3 pins: GND
  * 4x2 (1 pair per EEM): provide a reference clock signal to EEMs
  * 4x2 (2 per EEM): I2C
  * 4x2x8 (8 LVDS pairs per EEM)
  * 10 pins remaining for more power/GND

The signals are star-routed to several EEM DIN 41612 connectors in a barrel-shifted way so that a single EEM can claim up to four EEM links. The EEM connector pinout should be the same as Kasli. The four CLK/I2C/LVDS groups should be assigned in two different ways.

If the unused LVDS and clock stubs are not a problem, the backplane layout
could be a very flexible routing (where 4-link EEMs can be plugged into any slot) or a more fixed routing (but with no stub problems).

## Fixed backplane links

  * 0: 0, 1, 2, 3 (Kasli)
  * 1: 0, 1, 2, 3 (up to quad-link EEM)
  * 2: 1, 2, 3    (up to triple-link EEM)
  * 3: 2, 3       (up to double-link EEM)
  * 4: 3          (single-link EEM)

The EEM pitch should such that a 19 inch subrack can be filled.
Then if e.g. a single-link EEM is pliugged into slot 1, it will claim only
link 1 and all slots to the right (2-4) can be used. A double-link EEM plugged into slot 3 would claim links 2 and 3 and slot 4 can not be used.
An N-link EEM requires that the N-1 slots to the right of it are empty.

## Flexible backplane link routing

  * 0: 0, 1, 2, 3
  * 1: 1, 2, 3, 0
  * 2: 2, 3, 0, 1
  * 3: 3, 0, 1, 2
  * 4: 0, 1, 2, 3
  * 5: 1, 2, 3, 0
  * 6: 2, 3, 0, 1
  * etc.

The pitch between connectors on the backplane can e.g. be 4 HP.
If e.g. Kasli is plugged into slot 0, it drives all four groups from there.
Then if e.g. a single-link EEM is pliugged into slot 1, it will claim only
link 1. A double-link EEM plugged into slot 6 would claim links 2 and 3.
An N-link EEM requires that the N-1 slots to the right of it are empty.


## EEM Connector-to-DIN mezzanine

To clean up the wiring in the rack, one could design a simple mezzanine for Kasli (or the VHDCI carrier) that plugs into its EEM Connectors (four or 8) and then routes them through another (or two) DIN connectors to the backplane.
The backplane would then do all the wiring for EEMs significantly reducing the ribbon rats nest.