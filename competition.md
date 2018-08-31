
Software control infrastructure known to be in use on ion trap experiments:

|Name              | Origin                     | Link                             | Comment |
|-----             |----                        |-----                             | ------  |
|ARTIQ             | M-Labs, NIST Boulder, 2013 | [github](https://github.com/m-labs/artiq)| | 
|HFGui             | NIST Ion Storage, 2002     |         |  Being phased out at NIST in favour of ARTIQ       |
|Aluminizer        | NIST Ion Storage, 2006     | [github](https://github.com/nist-ionstorage/ionizer)| Written by Till Rosenband.  Used in the ion clock lab at NIST and maintained there by David Leibrandt.|
| Ion Control      | Sandia, 2016               | [github](https://github.com/pyIonControl) | Written and maintained by Peter Maunz at Sandia.  Also used by Monroe lab at UMD and Kim lab at Duke |
|M-ACTION          | ETH Zurich                 | [Mentioned in this paper](https://arxiv.org/abs/1705.02771) | |
|LabRad   | UCSB                   | [github](https://github.com/labrad/) [AMOLabRAD](https://github.com/AMOLabRAD/AMOLabRAD/wiki/)  [LabRAD Tools](https://github.com/HaeffnerLab/Haeffner-Lab-LabRAD-Tools/)| Originally developed by the Martinis Lab at UCSB for superconducting experiments.  AMOLabRAD and LabRAD tools are part of an effort by Haeffner Lab at Berkeley to use LabRAD in ion trap setups. | 
|TRiCS (Trapped Ion Control System) | Innsbruck | Mentioned briefly in [thesis1](https://quantumoptics.at/images/publications/dissertation/2017_guggemos_diss.pdf), [thesis2](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjYmIennp_bAhWwt1kKHf4hCKMQFggpMAA&url=https%3A%2F%2Fquantumoptics.at%2Fimages%2Fpublications%2Fdiploma%2Fdiplom_pauli.pdf&usg=AOvVaw3WNj7LnfLWwBLVv177FxWq) and [thesis3](http://www.diva-portal.org/smash/get/diva2:1203307/FULLTEXT01.pdf) | Developed by in-house programmer in Blatt lab at Innsbruck.  Also used by the Hennrich lab in Stockholm.|
|LabView          | National Instruments               |  | Pretty much the current default option, with many ion trap groups using it.|

Other software control infrastructure for (quantum) science:

|Name              | Origin           | Link                             | Comment |
|-----             |----              |-----                             | ------  |
|Labber            |2015      |[labber.org](http://labber.org/) |
|QITKAT            | Oak Ridge | [DOI](http://spie.org/Publications/Journal/10.1117/1.OE.53.8.086103?SSO=1) | Software-defined quantum communication systems |
|ZIO| | | A software framework for Linux device drivers aimed at supporting controls and data acquisition hardware. ZIO supports sub-nanosecond timestamps, block-oriented input and output and transport of meta-data with the data samples.| 
| LabScript | | [labscriptsuite.org](http://labscriptsuite.org/) [DOI](https://aip.scitation.org/doi/10.1063/1.4817213) | |



Control system hardware (and related) for quantum information experiments.

|Name              | Origin | Link                                      | Comment |
|-----             |----      |-----                                      |  ----       |
| Sinara            |2015 NIST Boulder, ARL | [github](https://github.com/sinara-hw) | open source hardware for ARTIQ| 
|Quantum Labber    |2018      |[quantum.labber.org](http://quantum.labber.org/) | |
| quTAU | | [qutau](http://www.qutools.com/quTAU/) | 8 channel, 81 ps TDC | 
|StelarIP| | 4dsp.com | tool for combining gateware IP developed by 4dsp.com |
|Swabian Instruments| | [swabianinstruments.com](http://swabianinstruments.com)|time-tagging system|
|                   |Blake Johnson BBN| [arXiv paper](https://arxiv.org/abs/1704.08314) | | 
| LiquidLab | | [liquidinstruments.com](https://liquidinstruments.com)|2 of 500 MS/s 12-bit ADCs
2 of 1 GS/s 16-bit DACs|
|OASIS | CERN | | White Rabbit enabled distributed osciloscope |
|Houke | Princeton | [arxiv](https://arxiv.org/pdf/1703.00942.pdf) | |
|LabRAD hardware| UCSB| [DOI](https://arxiv.org/abs/1507.03122) | |
|Easy Phi| | [link](http://easy-phi.unige.ch) | no activity on github since 2014 |
|M-ACTION Hardware| ETH Zurich | [Mentioned in this thesis](https://quantumoptics.at/images/publications/diploma/MichaelMeth_Kontrolle_Laserimpulse_QIV.pdf) | Developed in the Home Lab at ETH Zurich.  Being adopted by Blatt lab at Innsbruck. |
|AFCZ | Warsaw | [github](https://github.com/gkasprow/AFCZ/wiki) | FMC carrier based on Xilinx Zynq (ZU7EV or ZU11EG) |