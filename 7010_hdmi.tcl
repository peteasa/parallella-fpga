#
# Vivado (TM) v2015.2.1 (64-bit)
#
# 7010_hdmi.tcl: Tcl script for re-creating project '7010_hdmi'
#
#*****************************************************************************************
# NOTE: In order to use this script for source control purposes, please make sure that the
#       following files are added to the source control system:-
#
# 1. This project restoration tcl script (7010_hdmi.tcl) that was generated.
#
# 2. The following source(s) files that were local or imported into the original project.
#    (Please see the '$orig_proj_dir' and '$origin_dir' variable setting below at the start of the script)
#
#    "./7010_hdmi/archive_project_summary.txt"
#
# 3. The following remote source files that were added to the original project:-
#
#    "./7010_hdmi/7010_hdmi.srcs/sources_1/bd/elink2_top/elink2_top.bd"
#    "./7010_hdmi/7010_hdmi.srcs/sources_1/bd/elink2_top/hdl/elink2_top_wrapper.v"
#    "./7010_hdmi/7010_hdmi.srcs/constrs_1/imports/constraints/parallella_timing.xdc"
#    "./7010_hdmi/7010_hdmi.srcs/constrs_1/imports/constraints/parallella_z70x0_loc.xdc"
#
#*****************************************************************************************

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/7010_hdmi"]"

# Create project
## create_project 7010_hdmi ./7010_hdmi

# Open project
open_project 7010_hdmi/7010_hdmi.xpr

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [get_projects 7010_hdmi]
set_property "default_lib" "xil_defaultlib" $obj
set_property "part" "xc7z010clg400-1" $obj
set_property "simulator_language" "Mixed" $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set IP repository paths
set obj [get_filesets sources_1]
set_property "ip_repo_paths" "[file normalize "$origin_dir/oh/src/parallella/fpga/parallella_base"] [file normalize "$origin_dir/AdiHDLLib"]" $obj

# Rebuild user ip_repo's index before adding any source files
update_ip_catalog -rebuild

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$orig_proj_dir/7010_hdmi.srcs/sources_1/bd/elink2_top/elink2_top.bd"]"\
 "[file normalize "$orig_proj_dir/7010_hdmi.srcs/sources_1/bd/elink2_top/hdl/elink2_top_wrapper.v"]"\
 "[file normalize "$orig_proj_dir/archive_project_summary.txt"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$orig_proj_dir/7010_hdmi.srcs/sources_1/bd/elink2_top/elink2_top.bd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
if { ![get_property "is_locked" $file_obj] } {
  set_property "generate_synth_checkpoint" "0" $file_obj
}
set_property "used_in_simulation" "0" $file_obj

set file "$orig_proj_dir/7010_hdmi.srcs/sources_1/bd/elink2_top/hdl/elink2_top_wrapper.v"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "used_in_simulation" "0" $file_obj

# Set 'sources_1' fileset file properties for local files
# None

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property "top" "elink2_top_wrapper" $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$orig_proj_dir/7010_hdmi.srcs/constrs_1/imports/constraints/parallella_timing.xdc"]"
set file_added [add_files -norecurse -fileset $obj $file]
set file "$orig_proj_dir/7010_hdmi.srcs/constrs_1/imports/constraints/parallella_timing.xdc"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property "file_type" "XDC" $file_obj

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$orig_proj_dir/7010_hdmi.srcs/constrs_1/imports/constraints/parallella_z70x0_loc.xdc"]"
set file_added [add_files -norecurse -fileset $obj $file]
set file "$orig_proj_dir/7010_hdmi.srcs/constrs_1/imports/constraints/parallella_z70x0_loc.xdc"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property "file_type" "XDC" $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property "target_constrs_file" "$orig_proj_dir/7010_hdmi.srcs/constrs_1/imports/constraints/parallella_timing.xdc" $obj

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
# Empty (no sources present)

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
  create_run -name synth_1 -part xc7z010clg400-1 -flow {Vivado Synthesis 2014} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2014" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property "needs_refresh" "1" $obj
set_property "part" "xc7z010clg400-1" $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
  create_run -name impl_1 -part xc7z010clg400-1 -flow {Vivado Implementation 2014} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2014" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property "needs_refresh" "1" $obj
set_property "part" "xc7z010clg400-1" $obj
set_property "steps.write_bitstream.args.readback_file" "0" $obj
set_property "steps.write_bitstream.args.verbose" "0" $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:7010_hdmi"

update_compile_order -fileset sources_1
generate_target -quiet all [get_files $orig_proj_dir/7010_hdmi.srcs/sources_1/bd/elink2_top/elink2_top.bd]

set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-verilog_define CFG_ASIC=0} -objects [get_runs synth_1]

puts "INFO: Generated Output Products:7010_hdmi"

reset_run synth_1
launch_runs synth_1
wait_on_run synth_1
launch_runs impl_1
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
