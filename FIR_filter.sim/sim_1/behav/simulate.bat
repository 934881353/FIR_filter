@echo off
set xv_path=D:\\program\\vivado_anzhuang\\Vivado\\2015.4\\bin
call %xv_path%/xsim test_bench_behav -key {Behavioral:sim_1:Functional:test_bench} -tclbatch test_bench.tcl -view F:/VIVADO_program/FIR_filter_U060/FIR_filter/test_bench_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
