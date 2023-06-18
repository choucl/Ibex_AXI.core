#! /bin/bash

SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"            # relative
SCRIPT_PATH="$(cd -- "$SCRIPT_PATH" && pwd)"    # absolutized and normalized
if [[ -z "$SCRIPT_PATH" ]] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi
PROJ_PATH="$(dirname "$SCRIPT_PATH")"
echo "$SCRIPT_PATH"
echo "$PROJ_PATH"

fusesoc run --setup caslab:rtos:ibex_axi:1.0.0
cd ${PROJ_PATH}/build/caslab_rtos_ibex_axi_1.0.0/src
bash ${SCRIPT_PATH}/substitute.sh
cd ${PROJ_PATH}/build/caslab_rtos_ibex_axi_1.0.0/default-vivado

sed -i -e 's/read_verilog.*$//g' caslab_rtos_ibex_axi_1.0.0.tcl

FILE_SET=""
while read line; do
    FILE_SET="${FILE_SET} $line"
done < <(find "../src" -type f -name "*.sv" -or -name "*.svh" -or -name "*.v")

echo "add_files { $FILE_SET }" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "set_property source_mgmt_mode All [current_project]" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "update_compile_order -fileset sources_1" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "set_property  ip_repo_paths  ${PROJ_PATH}/ip_repo [current_project]" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "update_ip_catalog" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "source ${SCRIPT_PATH}/caslab_rtos_ibex_soc_design_2.tcl" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "make_wrapper -files [get_files ${PROJ_PATH}/build/caslab_rtos_ibex_axi_1.0.0/default-vivado/caslab_rtos_ibex_axi_1.0.0.srcs/sources_1/bd/caslab_rtos_ibex_soc_design_2/ip/caslab_rtos_ibex_soc_design_2_ibex_axi_verilog_wra_0_0/caslab_rtos_ibex_soc_design_2_ibex_axi_verilog_wra_0_0.xci] -top -fileset [get_filesets sources_1] -import" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "make_wrapper -files [get_files ${PROJ_PATH}/build/caslab_rtos_ibex_axi_1.0.0/default-vivado/caslab_rtos_ibex_axi_1.0.0.srcs/sources_1/bd/caslab_rtos_ibex_soc_design_2/caslab_rtos_ibex_soc_design_2.bd] -top" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "add_files -norecurse ${PROJ_PATH}/build/caslab_rtos_ibex_axi_1.0.0/default-vivado/caslab_rtos_ibex_axi_1.0.0.gen/sources_1/bd/caslab_rtos_ibex_soc_design_2/hdl/caslab_rtos_ibex_soc_design_2_wrapper.v" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "update_compile_order -fileset sources_1" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "set_property top caslab_rtos_ibex_soc_design_2_wrapper [current_fileset]" >> caslab_rtos_ibex_axi_1.0.0.tcl
echo "update_compile_order -fileset sources_1" >> caslab_rtos_ibex_axi_1.0.0.tcl


make caslab_rtos_ibex_axi_1.0.0.bit
cp ${PROJ_PATH}/build/caslab_rtos_ibex_axi_1.0.0/default-vivado/caslab_rtos_ibex_axi_1.0.0.gen/sources_1/bd/caslab_rtos_ibex_soc_design_2/hw_handoff/caslab_rtos_ibex_soc_design_2.hwh ${PROJ_PATH}/build/caslab_rtos_ibex_axi_1.0.0/default-vivado/caslab_rtos_ibex_axi_1.0.0.hwh
