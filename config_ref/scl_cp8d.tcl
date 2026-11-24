# ===============================================================================
# Ignytion IO - CRUCIBLE CORE
# Copyright (c) 2026 Ignytion IO. All rights reserved.
# Author      : IGNYTION_TECH
# File        : apb-scl-0.8u/config/scl_cp8d.tcl
# Created     : 2026-11-14
# Description : SCL CP8D (0.8um CMOS, 2-metal) PDK view shared by the Yosys and
#               OpenROAD stages. The only place PDK paths and cell names live.
# ===============================================================================
#
# Sourced by 04_synthesis and every OpenROAD stage. Reads PDK_ROOT and PDK from
# the environment (exported by config/pdk.mk). Nothing here is copied from the
# PDK: SCL marks its PDK files NDA-restricted, so they stay in PDK_ROOT and are
# only referenced by path.

if { ![info exists ::env(PDK_ROOT)] || $::env(PDK_ROOT) eq "" } {
    puts stderr "PDK_ROOT is not set. Run the flow through make (config/pdk.mk exports it)."
    exit 1
}
if { [info exists ::env(PDK)] && $::env(PDK) ne "" } {
    set scl_pdk $::env(PDK)
} else {
    set scl_pdk scl_cp8d
}

set scl_dir  [file join $::env(PDK_ROOT) $scl_pdk]
set scl_ref  [file join $scl_dir libs.ref digital_cp8d]
set scl_tech [file join $scl_dir libs.tech]

# --- PDK files ----------------------------------------------------------------
set scl(tech_lef)  [file join $scl_tech openlane digital_cp8d lef tech_cp8d.lef]
set scl(cell_lef)  [file join $scl_ref lef core_cp8d.lef]
set scl(lib,typ)   [file join $scl_ref lib cp8d_core_typ.lib]
set scl(lib,max)   [file join $scl_ref lib cp8d_core_max.lib]
set scl(lib,min)   [file join $scl_ref lib cp8d_core_min.lib]
set scl(rcx_rules) [file join $scl_tech openrcx scl800.rcx.lib]

# Liberty corners (from each library header):
#   typ : 5.0 V,  27 C   -- implementation and the default STA corner
#   max : 4.5 V,  85 C   -- slowest; synthesis maps against it (setup sign-off)
#   min : 5.5 V, -20 C   -- fastest; hold sign-off
set scl(corners) {typ max min}

# --- Cells and technology facts -----------------------------------------------
set scl(site)        CORE
set scl(power_net)   VDD
set scl(ground_net)  GROUND
set scl(tie_hi)      {VDDCON TIEHI}
set scl(tie_lo)      {VSSCON TIELO}
set scl(buffer)      {BUFF00 IN1 OUT1}
set scl(cts_buffer)  BUFF00
set scl(fillers)     {FILLER1 FILLER2 FILLER3 FILLER4 FILLER5 FILLER6}

# Two routing layers only: metal1 runs horizontally, metal2 vertically.
set scl(hor_layer)   metal1
set scl(ver_layer)   metal2
set scl(rail_width)  7.0

# Layout-only rules not enforced by the router's metal DRC. These are
# implementation constraints; SCL masks and verification decks stay intact.
set scl(poly_layer) poly
set scl(cut_layer) via
set scl(boron_padding_masters) {NND200}
set scl(boron_padding_sites) 1
set scl(pin_fix_master) ADNR00
set scl(pin_fix_term) OUT1
set scl(pin_fix_layer) metal2
set scl(pin_fix_left_extra_um) 0.4

# Routing tracks, from the PDK's libs.tech/openlane/tracks.info.
set scl(tracks) {
    metal1 {0 3.7 0 3.7}
    metal2 {1.95 3.9 0 3.9}
}

# --- Wire RC for estimation (set_wire_rc) -------------------------------------
# ASSUMPTION, pending confirmation from SCL. The tech LEF gives
#   metal1: RPERSQ 0.07, WIDTH 1.7, CPERSQDIST 0.027, EDGECAPACITANCE 1e-4
#   metal2: RPERSQ 0.04, WIDTH 2.0, CPERSQDIST 0.011, EDGECAPACITANCE 1e-4
# Read in LEF units (pF/um^2) the area capacitance is 27 / 11 fF/um^2, about
# 1000x any real metal layer; letting OpenROAD derive wire RC from the LEF makes
# a 250 um clock segment ~5.6 pF and TritonCTS aborts (CTS-0065, LUT overflow).
# The PDK's OpenRCX rules (scl800.rcx.lib) carry only zero coefficients, so
# they cannot supply the value either. The flow therefore reads CPERSQDIST as
# fF/um^2 and keeps every other LEF number as written:
#   R [kOhm/um] = RPERSQ / WIDTH / 1000
#   C [pF/um]   = CPERSQDIST * 1e-3 * WIDTH + 2 * EDGECAPACITANCE
# giving ~0.25 fF/um (metal1) and ~0.22 fF/um (metal2).
proc scl_layer_rc {rpersq width cpersq edgecap} {
    return [list [expr {$rpersq / $width / 1000.0}] \
                 [expr {$cpersq * 1e-3 * $width + 2.0 * $edgecap}]]
}
set scl(wire_rc,metal1) [scl_layer_rc 0.07 1.7 0.027 1e-4]
set scl(wire_rc,metal2) [scl_layer_rc 0.04 2.0 0.011 1e-4]

# The tech LEF puts no RESISTANCE on the "via" cut layer (only on the M2_M1
# via, 0.3375 ohm per cut). OpenROAD's parasitic estimator dereferences the
# missing cut-layer value and crashes (SIGSEGV in getCutLayerRes) during
# timing-driven global routing, so the via resistance is set explicitly here
# from the LEF's own M2_M1 value, in kOhm.
set scl(via_res,via) [expr {0.3375 / 1000.0}]

# Apply the parasitic model above to every layer the router and estimators use,
# then the per-length wire RC used by CTS and placement-based estimates.
# SCL's OpenLane config uses metal2 for both data and clock wire estimates.
proc scl_set_parasitics {} {
    global scl
    foreach layer [list $scl(hor_layer) $scl(ver_layer)] {
        lassign $scl(wire_rc,$layer) res cap
        set_layer_rc -layer $layer -resistance $res -capacitance $cap
    }
    set_layer_rc -via via -resistance $scl(via_res,via)
    lassign $scl(wire_rc,$scl(ver_layer)) res cap
    set_wire_rc -signal -resistance $res -capacitance $cap
    set_wire_rc -clock  -resistance $res -capacitance $cap
}

# Fail fast, with a fix, when a stage needs a PDK file that is not there.
proc scl_require {args} {
    global scl
    foreach key $args {
        if { ![file exists $scl($key)] } {
            puts stderr "Missing SCL PDK file ($key): $scl($key)"
            puts stderr "Run 'igny run make pdk' first, or set SCL_PDK_ROOT to an existing SCL CP8D install."
            exit 1
        }
    }
}

proc scl_liberty {corner} {
    global scl
    if { [lsearch -exact $scl(corners) $corner] < 0 } {
        puts stderr "Unsupported SCL corner '$corner'. Use one of: $scl(corners)"
        exit 1
    }
    return $scl(lib,$corner)
}
