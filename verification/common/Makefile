
#make VCS or make VCS_NEW can start sim

#top name
OBJ_NAME = sim
ALL_DEFINE = +define+DUMP_VPD

#RTL and Testbench to add
SIM_FILE:=sim.sv

# Code Coverage command
CM = -cm line+cond+fsm+branch+tgl
CM_NAME = -cm_name $(OBJ_NAME).vdb
CM_DIR = -cm_dir ./$(OBJ_NAME).vdb

# vpd file name
VPD_NAME = +vpdfile+$(OBJ_NAME).vpd

# VCS compile command
VCS = vcs 	-full64 -sverilog +v2k -timescale=1ns/1ns 			\
	  		-debug_all 								  		  	\
			-notice 								  		  	\
			-LDFLAGS -Wl,--no-as-needed          \
			+notimingcheck 							  		  	\
			+nospecify -Mupdate						  		  	\
			+vcs+flush+all 							  		  	\
        	+warn=noCDNYI,noIPDW,noILLGO,noTMR,noPHNE,noIRIID-W \
			$(novas_args) 										\
			$(CM) 												\
			$(CM_DIR) 											\
			$(ALL_DEFINE) 										\
			$(VPD_NAME) 										\
			-o $(OBJ_NAME) 										\
			-l compile.log 

VCS_NEW = vcs -full64 -timescale=1ns/1ns 			\
	  		-debug_all 								  		  	\
			-notice 								  		  	\
			+notimingcheck 							  		  	\
			+nospecify -Mupdate						  		  	\
			+vcs+flush+all 							  		  	\
        	+warn=noCDNYI,noIPDW,noILLGO,noTMR,noPHNE,noIRIID-W \
			$(novas_args) 										\
			$(CM) 												\
			$(CM_DIR) 											\
			$(ALL_DEFINE) 										\
			$(VPD_NAME) 										\
			-o $(OBJ_NAME) 										\
			-l compile.log 

VCS_NOCOV = vcs 	-full64 -timescale=1ns/1ns 			\
	  		-debug_all 								  		  	\
			-notice 								  		  	\
			-LDFLAGS -Wl,--no-as-needed          \
			+notimingcheck 							  		  	\
			+nospecify -Mupdate						  		  	\
			+vcs+flush+all 							  		  	\
        	+warn=noCDNYI,noIPDW,noILLGO,noTMR,noPHNE,noIRIID-W \
			$(novas_args) 										\
			$(ALL_DEFINE) 										\
			$(VPD_NAME) 										\
			-o $(OBJ_NAME) 										\
			-l compile.log 

# Simulation command
SIM = ./$(OBJ_NAME) 				\
	  $(CM) $(CM_NAME) $(CM_DIR) 	\
	  $(VPD_NAME) 					\
	  -l sim.log

SIM_NOCOV = ./$(OBJ_NAME) 				\
	  $(CM) $(CM_NAME) $(CM_DIR) 	\
	  $(VPD_NAME) 					\
	  -l sim.log

.PHONY:vcs sim cov debug clean vlogan

vlogan:
	vlogan $(SIM_FILE) -full64 -sverilog +v2k

# Start VCS compile
vcs:
	$(VCS) $(SIM_FILE) -top $(OBJ_NAME)

vcs_new:vlogan
	$(VCS_NEW) -top $(OBJ_NAME) 

vcs_nocov:
	$(VCS_NOCOV) -top $(OBJ_NAME) 

# Start simulation
sim:
	$(SIM)

sim:
	$(SIM_NOCOV)

debug:
	dve -vpd $(OBJ_NAME).vpd &

# Open the coverage report with DVE
cov:
	dve -covdir *.vdb &

clean:
	rm -rf ./csrc *.daidir *.log *.vpd *.vdb simv* *.key *race.out*
	rm -rf AN.DB
	rm -rf novas*
	rm -rf DVEfiles
	rm -rf $(OBJ_NAME)
	rm -rf urgReport


