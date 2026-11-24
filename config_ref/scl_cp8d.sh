# ===============================================================================
# Ignytion IO - CRUCIBLE CORE
# Copyright (c) 2026 Ignytion IO. All rights reserved.
# Author      : IGNYTION_TECH
# File        : apb-scl-0.8u/config/scl_cp8d.sh
# Created     : 2026-11-14
# Description : SCL CP8D PDK view for the Bash stages (10_gds,
#               11_physical_verification). Mirrors config/scl_cp8d.tcl.
# ===============================================================================
#
# Source it; do not execute it. Expects PDK_ROOT (and optionally PDK) from
# config/pdk.mk.

if [ -z "${PDK_ROOT:-}" ]; then
    echo "PDK_ROOT is not set. Run the flow through make (config/pdk.mk exports it)." >&2
    exit 1
fi

scl_dir="$PDK_ROOT/${PDK:-scl_cp8d}"
scl_ref="$scl_dir/libs.ref/digital_cp8d"
scl_tech="$scl_dir/libs.tech"

scl_tech_lef="$scl_tech/openlane/digital_cp8d/lef/tech_cp8d.lef"
scl_cell_lef="$scl_ref/lef/core_cp8d.lef"
scl_cell_gds="$scl_ref/gds/std_cells_cp8d.gds"
scl_cell_cdl="$scl_ref/cdl/core_iolib_cp8d.cdl"
scl_layer_map="$scl_tech/klayout/tech/scl_cp8d.map"
scl_drc_deck="$scl_tech/klayout/tech/drc/drc.lydrc"
scl_lvs_deck="$scl_tech/klayout/tech/lvs/lvs.lylvs"
scl_verilog2spice="$scl_ref/project_scl_cp8d/sample_project_files_cp8d/5_klayout/script/verilog2spice.py"
scl_power_net="VDD"
scl_ground_net="GROUND"

scl_require() {
    local f
    for f in "$@"; do
        if [ ! -f "$f" ]; then
            echo "Missing SCL PDK file: $f" >&2
            echo "Run 'igny run make pdk' first, or set SCL_PDK_ROOT to an existing SCL CP8D install." >&2
            exit 1
        fi
    done
}
