# CharlesDesignWare

This repository contains common Verilog circuit designs and the entire RTL to GDSII flow scripts.  

## Directory Structure Explanation

### `common`
Contains common Verilog modules used across different designs:
- `dffe.v`, `dffre.v`, `dffr.v`, `dff.v`: DFFs with or without reset and enable port (for saving area and avoid error during x-prop test).
- `fifo.v`: First-In-First-Out (FIFO) buffer written in DFF.
- `rs.v`: Register Slice to break down the timing of the handshack signal.

### `document`
Contains project documentation

### `hdl`
Contains the HDL (Hardware Description Language) code for different customized designs:
- `blk_divider`: example design.
  - `divider.v`: Verilog code for the divider.
  - `sanity.f`: File possibly containing sanity test configurations.

### `layout`
Contains layout scripts and configurations for the `blk_divider` block:
- `clean`, `run`: Scripts likely related to cleaning the workspace and running layout tasks.
- `scripts`: Directory for layout scripts.
  - `divider.ioc`, `mmc2.view`, `top.tcl`: Various layout-related configuration and script files.

### `script`
Contains project scripts that is normally sourced before using EDAs:
- `sourceme.sh`: A shell script to set up the environments.

### `syn`
Contains synthesis scripts and configurations for different blocks:
- `blk_divider`: example design.
  - `clean`, `run`, `run.tcl`: Scripts for cleaning the workspace, running synthesis tasks, and the main synthesis script.
  - `dut.constraints.tcl`: Synthesis constraints

### `verification`
Contains verification code and scripts:
- `blk_divider`: example design.  
  - `th`: Directory for test harness files.
    - `divider_tb.v`, `tb_prince_core.v`, `tb_prince.v`, `tb_prince_cfb.v`: Testbench files for different modules.
    - `sim.f`: filelist for simulation.
  - `ut_behav`, `ut_layout`, `ut_syn`: Directories for behavioral, layout, and synthesis verification.
    - `clean`, `run`, `run_vcs`: Scripts for cleaning, running simulations, and running VCS (a simulator).
