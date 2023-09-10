#define parameter
cov_en     ?=y
#cov tool can be verdi or dve or web
cov_tool   ?=verdi
arch_sel   ?=
incdir     ?=../tb
#testbench name
tb_name    ?=top_tb
#testcase name
tc_name    ?=round_case0
#override
time_cover ?=n
#use vcs's in-built uvm?
uvm_vcs    ?=n
UVM_HOME   ?=../../../common/uvm_1_2
#Sim with sdf enable
sdf_en     ?=n
#user timescale
time_scale ?=1ns/1ns
#wave related 
wave_type   =fsdb
wave_path   =../wave

#TIME_CMD condition
ifeq ($(time_cover),y)
  TIME_CMD=-override_timescale
else
  TIME_CMD=-timescale
endif

ifeq ($(cov_tool),web)
  cov_cmd=urg -dir $(tc_name).vdb -report $(tc_name) -full64 
endif
ifeq ($(cov_tool),dve)
  cov_cmd=dve -covdir $(tc_name).vdb -full64 
endif
ifeq ($(cov_tool),verdi)
  cov_cmd=verdi -cov -covdir $(tc_name).vdb -nologo 
endif

#uvm_vcs condition
ifeq ($(uvm_vcs),y)
  UVM_CMD=-ntb_opts uvm
else
  UVM_CMD=-debug_pp +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm_pkg.sv ${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS
endif
UVM_COMPILE=vlogan -sverilog $(UVM_CMD) +v2k -full64 $(TIME_CMD)=$(time_scale)

#include cmd
ifneq ($(incdir),)
  INC_CMD =+incdir+$(incdir)
else
  INC_CMD =
endif

#SDF realted
ifeq ($(sdf_en),y)
  SDF_CMD=-sdfverbose -negdelay +neg_tchk +maxdelays +iopath+edge+max
else
  SDF_CMD=+notimingcheck +nospecify
endif

ALL_DEFINE = +define+DUMP_VPD

#sim file and work name define
ifneq ($(arch_sel),)
  SIM_FILE:=
  ifeq ($(arch_sel),xilinx)
    SIM_FILE:=glbl.v
    WORK_NAME:=work.$(tb_name) work.glbl
  else
    WORK_NAME:=work.$(tb_name)
  endif
else
  SIM_FILE:=
  WORK_NAME:=work.$(tb_name)
endif

#SIM_FILE+=-v ~/sm13_lib/STD/Verilog/*.v
#SIM_FILE+=-v ~/smic180/digital/sc/verilog/smic18.v

#code coverage commond
CM = -cm line+cond+fsm+branch+tgl+assert
CM_NAME = -cm_name $(tc_name)
CM_DIR = -cm_dir ./$(tc_name).vdb

#vpd name
VPD_NAME = +vpdfile+$(tc_name).vpd

#VCS compile commond
VCS = vcs -full64 $(TIME_CMD)=$(time_scale)    \
          -debug_all                           \
          -notice                              \
	  -LDFLAGS -Wl,--no-as-needed          \
		  $(SDF_CMD)                           \
          -Mupdate                             \
          +vcs+flush+all                       \
          +warn=noCDNYI,noIPDW,noILLGO,noTMR,noPHNE,noIRIID-W \
          $(novas_args)                       \
          -sverilog                            \
          $(UVM_CMD)                           \
          $(INC_CMD)                           \
          $(ALL_DEFINE)                        \
          -o $(tb_name)                       \
          -l compile.log                       \

#Simulation commond
SIM = ./$(tb_name)                            \
      $(VPD_NAME)                              \
      -l $(tc_name).log

ifeq ($(cov_en),y)
  VCS +=$(CM)                                  \
        $(CM_DIR)                              \
        $(VPD_NAME)
  SIM += $(CM) $(CM_NAME) $(CM_DIR)
endif

.PHONY:vcs sim cov debug clean help

#compile files
vcs:
	$(UVM_COMPILE)
	$(VCS) -F ./filelist.f -v $(SIM_FILE) work.$(tb_name)

sim:
	$(SIM) +UVM_TESTNAME=$(tc_name) +WAVE_PATH=$(wave_path) +WAVE_TYPE=$(wave_type)

wave:
	verdi -sv -F ./filelist.f -ssf $(wave_path)/$(tc_name).fsdb &

debug:
	dve -vpd $(tc_name).vpd

merge:
	urg -dir *.vdb -dbname simv

#open coverage report
cov:
	$(cov_cmd) &

clean:
	@rm -rf ./csrc *.daidir *.log *.vpd *.vdb simv* *.key *race.out*
	@rm -rf *.args vc_hdrs.h glbl.v
	@rm -rf novas.conf novas.rc .vlogansetup.args verdiLog
	@rm -rf AN.DB DVEfiles
	@rm -rf urgReport $(tb_name) $(tc_name)

help:
	@echo "#########################################################"
	@echo "#1  Please modify arch_sel,cov_en and incdir;           #"
	@echo "#2  Please modify file path and SIM_FILE;               #"
	@echo "#3  Please modify tb_name;                              #"
	@echo "#4  Please modify ALL_DEFINE;                           #"
	@echo "#5  Please modify time_scale;                           #"
	@echo "#6  Please modify time_cover;                           #"
	@echo "#7  Please modify uvm_vcs;                              #"
	@echo "#8  Use make vcs to compile source file;                #"
	@echo "#9  Use make sim to run binary file;                    #"
	@echo "#10 Use make wave to watch wave from verdi;             #"
	@echo "#11 Use make clean to clean file;                       #"
	@echo "#12 Must add fsdb generate line on your testbench;      #"
	@echo "#13 Must add delay on your file read function;          #"
	@echo "#########################################################"


