# ARVM-FunctionalCoverage

The ARVM-FunctionalCoverage sub-project is under the OpenHW VTG and part of the Advanced RISC-V Verification Methodology project.

The focus of this project is in developing requirements for VIPs (such as functional coverage) that can be used for many different core configurations/implementations.

Work started early Oct 2022 in this project.

Examples of some (current focus) of the automatically generated functional coverage is here (these are currently an incomplete wip):   
- [RV32F for CV32E40Pv2](https://github.com/openhwgroup/advanced-riscv-verification-methodologies/tree/main/ARVM-FunctionalCoverage/20221222)
- [RV32Zc for CV32E40S](https://github.com/openhwgroup/advanced-riscv-verification-methodologies/tree/main/ARVM-FunctionalCoverage/20221222)

These are the two OpenHW core verification projects providing requirements for this ARVM-FunctionalCoverage project.  

What is provided is:
- .csv files which list the coverage generated
- .svh files which are the SystemVerilog source files generated

These files work from the [RVVI-TRACE](https://github.com/riscv-verification/RVVI/tree/main/RVVI-TRACE) data from the DUT/Core's tracer.

We want input on what more is needed in the functional coverage than that currently being generated.

We expect we will use the issue tracker of this repository with sub-project label of ARVM-FunctionalCoverage for questions, issues, enhancements for this sub-project and the generated coverage files...

Latest status report is: [found here](https://github.com/openhwgroup/programs/blob/master/TGs/verification-task-group/projects/ARVM-FunctionalCoverage/meetings).

There is information on the initial public release of what is now called riscvISACOV [here](https://github.com/riscv-verification/riscvISACOV). This includes information on all of the RISC-V instruction extensions currently supported.


