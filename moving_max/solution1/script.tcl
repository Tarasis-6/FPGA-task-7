############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
## Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
############################################################
open_project moving_max
set_top moving_max
add_files moving_max.cpp
add_files -tb tb.cpp
open_solution "solution1" -flow_target vivado
set_part {xc7z010iclg225-1L}
create_clock -period 10 -name default
config_compile -pipeline_loops 0
#source "./moving_max/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
