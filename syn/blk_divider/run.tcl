################################################################################
# Filename: dc.tcl
# Author: ZHU Jingyang
# Email: jzhuak@connect.ust.hk
# Affiliation: Hong Kong University of Science and Technology
# -------------------------------------------------------------------------------
# This is the template Design Compiler script for ELEC5160/EESM5020.
################################################################################
set WORK_ROOT $env(WORK_ROOT)
set HDL_PATH ${WORK_ROOT}/hdl/blk_divider
set TOP_MODULE_NAME divider

# TSMC 28nm library
# set DB_PATH /home/ic/TechLib/TSMCN28_SYN/CCS
# set DB_NAME tcbn28hpcplusbwp7t35p140tt0p9v85c_ccs.db

# TSMC 40nm library
set DB_PATH /home/ic/TechLib/t28_hpcp/logic/tcbn28hpcplusbwp12t40p140_180a/AN61001_20180514/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn28hpcplusbwp12t40p140_180a
set DB_NAME tcbn28hpcplusbwp12t40p140tt0p9v85c_ccs.db
# set DB_NAME tcbn28hpcplusbwp12t40p140tt1v0p9v85c_ccs.db

################################################################################
# Step 0: create directories for results and reports
################################################################################
file mkdir reports; # store area, timing, power reports
file mkdir results; # store design

################################################################################
# Step 1: digital standard cell library set up
# You should specify the following paths accordingly:
# - search_path
# - target_library
# - link_library
################################################################################
set_app_var search_path ". $WORK_ROOT/common $search_path"
set_app_var search_path ". ${DB_PATH} ${HDL_PATH} $search_path"
set_app_var target_library "${DB_NAME}"
set_app_var link_library "* $target_library"

################################################################################
# Step 2: import design
# You should specify the HDL files for your design accordingly.
# Note: the HDL files should be located in the search_path you defined above.
# Please do NOT import testbench or behavior memory model here.
################################################################################
define_design_lib WORK -path ./WORK
analyze -format verilog -vcs "-f $HDL_PATH/sanity.f +libext+.v"

elaborate ${TOP_MODULE_NAME}; # top module name

# store the unmapped results
write -hierarchy -format ddc -output results/${TOP_MODULE_NAME}.unmapped.ddc

################################################################################
# Step 3: constrain your design
# You should specify the critical path, the input & output delay and the
# environment attribute of your design, so that Design Compiler can correctly
# synthesize your design with the required specfication.
################################################################################
# All the constraints are written in the following tcl script
source dut.constraints.tcl

################################################################################
# Create default path groups
#
# Seperate these paths can help improve optimization results.
################################################################################
set ports_clock_root \
  [filter_collection [get_attribute [get_clocks] sources] object_class==port]
group_path -name REGOUT -to [all_outputs]
group_path -name REGIN -from [remove_from_collection [all_inputs] \
  ${ports_clock_root}]
group_path -name FEEDTHROUGH -from \
  [remove_from_collection [all_inputs] ${ports_clock_root}] -to [all_outputs]

################################################################################
# Apply Additional Optimization Constraints
################################################################################
# Prevent assignment statements in the Verilog netlist.
set_fix_multiple_port_nets -all -buffer_constants

################################################################################
# Check for Design Errors. It is a good habit to check the design before you run
# the synthesis.
################################################################################
check_design -summary
check_design > reports/${TOP_MODULE_NAME}.check_design.rpt; # dump to the file

################################################################################
# Step 4: compile the design
# There exits lots of option for compile command. Please check the manual of
# compile for further info.
################################################################################
compile_ultra

################################################################################
# Note: compile_ultra does not work for some open source libraries, i.e. Nangate
# since there are some cells missing for these libraries.
# Sol: use compile instead. You can use compile_ultra for the commerial library
# such TSMC45nm, which has a complete set of gates supported.
#
# compile_ultra -no_autoungroup; # keep hierarchy for the purpose of debug
################################################################################

# High-effort area optimization which improves the area without degrading the
# timing or leakage of the compiled design
optimize_netlist -area

################################################################################
# Step 5: write out final design and reports
# The files include:
# - .ddc: binary format used for subsequent Design Compiler sessions
# - .v: Verilog netlist for gate-level simulation and P&R
# - .sdf: SDF backannotated file containing gate and net latency
# - .sdc: SDC constraints for ASCII flow
################################################################################
change_names -rules verilog -hierarchy

# Write out design
write -format verilog -hierarchy -output results/${TOP_MODULE_NAME}.mapped.v
write -format ddc -hierarchy -output results/${TOP_MODULE_NAME}.mapped.ddc
write_sdf results/${TOP_MODULE_NAME}.mapped.sdf
write_sdc -nosplit results/${TOP_MODULE_NAME}.mapped.sdc

# Generate reports
report_qor > reports/${TOP_MODULE_NAME}.mapped.qor.rpt
report_timing -transition_time -nets -attribute -nosplit \
  > reports/${TOP_MODULE_NAME}.mapped.timing.rpt
report_area -nosplit > reports/${TOP_MODULE_NAME}.mapped.area.rpt
report_power -nosplit > reports/${TOP_MODULE_NAME}.mapped.power.rpt

################################################################################
# Exit Design Compiler
################################################################################
exit
