# Shared setup for every OpenROAD script: PDK paths, RC model, physical rules.
source config_ref/scl_cp8d.tcl
source config_ref/physical_rules.tcl
foreach c {typ max min} {
    set pads($c) [file join $scl_ref lib cp8d_pads_$c.lib]
}
set dont_use_cells {DELY00 TBUF00 TBUF01 TINV00 TINV01 TRAN00}
