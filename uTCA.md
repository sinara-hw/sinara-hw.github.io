# Overview

MicroTCA (uTCA) is Sinara's preferred form-factor for hardware with high-speed data converters requiring deterministic phase control, such as the [_Sayma_](Sayma) 2.4 GSPS smart arbitrary waveform generator (SAWG). 

uTCA is a modular, open standard originally developed by the telecommunications industry. It allows a single rack master -- the Micro TCA Carrier Hub (MCH) -- to control multiple slave boards, known as Advanced Mezzanine Cards (AMCs) via a high-speed digital backplane. uTCA chassis and backplanes are available commercially of the shelf (COTS). 

We make use of the most recent extension to the uTCA standard, uTCA.4. Originating in the high-energy and particle physics (HEPP) community, uTCA.4 introduces rear-transition modules (RTMs) along with a second backplane for low-noise RF signals (RFBP). Each RTM connects to an AMC (one RTM per AMC). Typically, the AMCs hold FPGAs and other high-speed digital hardware, communicating with the MCH via gigabit serial links over the AMC backplane. The RTMs hold data converters and other low-noise analog components, controlled by the corresponding AMC. The RFBP provides low-noise clocks and local oscillators (LOs). The RTMs and RFBP are screened from the AMCs to minimise interference from the high-speed digital logic.



![Micro TCA chassis with 3 Sayma AMC modules inserted](https://github.com/m-labs/sinara/blob/master/Drawings/MTCA_Front.jpg)

(above) Micro TCA chassis with 3 Sayma AMC modules inserted. 

Micro TCA chassis with 4 RTM modules inserted. One of them with 4 BaseMod AFE mezzanines installed.

![Micro TCA chassis with 4 RTM modules inserted. One of them has 4 BaseMod AFE mezzanines installed.](https://github.com/m-labs/sinara/blob/master/Drawings/MTCA_Back.jpg)

# uTCA.4 RF Backplane

[RF BP datasheet](http://mtca.desy.de/sites/site_mtca/content/e172206/e205636/e212584/e248086/uRFB_concept_Datasheet_19.12.2014_eng.pdf) [RF BP measurements](http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=7097413&tag=1)

# uTCA in Sinara

[_Metlino_](Metlino) has been developed as an MCH optimised for use in Sinara. It can either be the ARTIQ master or a slave, connected to the master via DRTIO. 

uTCA hardware interfaces with the extension modules either directly, using a [VHDCI carrier](VHDCICarrier), or indirectly, using a Kasli DRTIO slave. 

To do:
* Some images to illustrate what uTCA systems look like
* Explain how Baikal etc fit in
* Add BP schematics that show what the connectivity is
* Any more useful information?

# uTCA parts and suppliers

Add parts and suppliers from the issues list...

# Schematic / Layout Viewer
Mentor has a free tool called [visECAD Viewer](https://www.mentor.com/pcb/downloads/visecad-viewer/). 