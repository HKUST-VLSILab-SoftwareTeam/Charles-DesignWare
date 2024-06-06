simSetSimulator "-vcssv" -exec \
           "/home/ic/github/Charles-DesignWare/verification/blk_prince/ut_behav/simv" \
           -args \
           "+vcs+dumpvars +vc +v2k +lint=all +vcs+initreg+random -a vcs_sim.log"
debImport "-dbdir" \
          "/home/ic/github/Charles-DesignWare/verification/blk_prince/ut_behav/simv.daidir"
debLoadSimResult \
           /home/ic/github/Charles-DesignWare/verification/blk_prince/ut_behav/novas.fsdb
wvCreateWindow
srcHBSelect "tb_prince.dut" -win $_nTrace1
srcSetScope "tb_prince.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_prince.dut" -win $_nTrace1
srcHBSelect "tb_prince.dut.core" -win $_nTrace1
srcSetScope "tb_prince.dut.core" -delim "." -win $_nTrace1
srcHBSelect "tb_prince.dut.core" -win $_nTrace1
srcHBSelect "tb_prince.dut.core.reg_update" -win $_nTrace1
srcHBSelect "tb_prince.dut.core.prince_core_ctrl" -win $_nTrace1
srcSetScope "tb_prince.dut.core.prince_core_ctrl" -delim "." -win $_nTrace1
srcHBSelect "tb_prince.dut.core.prince_core_ctrl" -win $_nTrace1
srcHBSelect "tb_prince.dut.core.reg_update" -win $_nTrace1
srcSetScope "tb_prince.dut.core.reg_update" -delim "." -win $_nTrace1
srcHBSelect "tb_prince.dut.core.reg_update" -win $_nTrace1
srcHBSelect "tb_prince.dut" -win $_nTrace1
srcHBSelect "tb_prince.dut.core" -win $_nTrace1
srcSetScope "tb_prince.dut.core" -delim "." -win $_nTrace1
srcHBSelect "tb_prince.dut.core" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 42 -pos 1 -win $_nTrace1
srcHBSelect "tb_prince.dut.core.prince_core_ctrl" -win $_nTrace1
srcSetScope "tb_prince.dut.core.prince_core_ctrl" -delim "." -win $_nTrace1
srcHBSelect "tb_prince.dut.core.prince_core_ctrl" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "encdec" -line 45 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "reset_n" -line 43 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "encdec" -line 45 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 42 -pos 1 -win $_nTrace1
srcSelect -signal "reset_n" -line 43 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "encdec" -line 45 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "ready" -line 47 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "next" -line 46 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "ready" -line 47 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "key" -line 49 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "block" -line 51 -pos 1 -win $_nTrace1
wvSetCursor -win $_nWave2 34996.905023
wvSetCursor -win $_nWave2 37137.303504 -snap {("G1" 4)}
wvZoomAll -win $_nWave2
srcHBSelect "tb_prince.dut.core" -win $_nTrace1
srcHBSelect "tb_prince.dut.core" -win $_nTrace1
srcSetScope "tb_prince.dut.core" -delim "." -win $_nTrace1
srcHBSelect "tb_prince.dut.core" -win $_nTrace1
srcHBSelect "tb_prince.dut" -win $_nTrace1
srcSetScope "tb_prince.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_prince.dut" -win $_nTrace1
srcHBSelect "tb_prince.dut.core" -win $_nTrace1
srcSetScope "tb_prince.dut.core" -delim "." -win $_nTrace1
srcHBSelect "tb_prince.dut.core" -win $_nTrace1
debExit
