# ARVM-FunctionalCoverage

The ARVM-TestbenchQuality sub-project is under the OpenHW VTG and part of the Advanced RISC-V Verification Methodology project.

The focus of ARVM-FunctionalCoverage is in developing open-source VIPs (such as functional coverage) that can be used for many different core configurations/implementations.

Work started early Oct 2022 in this project.

Examples of some (current focus) of the automatically generated functional coverage is here (these are currently an incomplete wip):   
- [RV32F for CV32E40Pv2](20221201/CV32E40Pv2_riscvISACOV)
- [RV32Zc for CV32E40S](20221201/CV32E40S_riscvISACOV)

What is provided is:
- .csv files which list the coverage generated
- .svh files which are the SystemVerilog source files generated

These files work from the RVVI-TRACE data from the DUT/Core's tracer.

We want input on what more is needed in the functional coverage than that currently being generated.

We expect we will use the issue tracker of this repository with sub-project label of ARVM-FunctionalCoverage for questions, issues, enhancements for this sub-project and the generated coverage files...

Latest status report is: [monthly-report-2022-Nov-21.md](https://github.com/openhwgroup/programs/blob/master/TGs/verification-task-group/projects/ARVM-FunctionalCoverage/meetings/2022/monthly-report-2022-Nov-21.md).


