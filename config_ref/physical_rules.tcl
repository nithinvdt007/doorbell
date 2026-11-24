# Implementation constraints for the CP8D rules absent from route DRC.
# Sourced after config/scl_cp8d.tcl. Foundry decks and masks are unchanged.

proc scl_apply_implant_padding {} {
    global scl
    set_placement_padding -masters $scl(boron_padding_masters) \
        -left $scl(boron_padding_sites) -right $scl(boron_padding_sites)
}

proc scl_release_implant_padding {} {
    global scl
    # Legalized gate positions stay put. Implant-free fillers may now occupy
    # the reserved sites without failing the generic padding checker.
    set_placement_padding -masters $scl(boron_padding_masters) -left 0 -right 0
}

proc scl_correct_router_pin_abstracts {} {
    global scl
    set block [ord::get_db_block]
    set layer [[$block getTech] findLayer $scl(pin_fix_layer)]
    set extra [ord::microns_to_dbu $scl(pin_fix_left_extra_um)]
    set count 0
    foreach inst [$block getInsts] {
        set master [$inst getMaster]
        if {[$master getName] ne $scl(pin_fix_master)} {
            continue
        }
        set term [$master findMTerm $scl(pin_fix_term)]
        if {$term eq "NULL" || $term eq ""} {
            error "Missing pin for CP8D routing-abstract correction"
        }
        foreach pin [$term getMPins] {
            foreach box [$pin getGeometry] {
                if {[$box getTechLayer] eq $layer} {
                    # ADNR00 OUT1's GDS Metal2 pad extends 0.4 um farther
                    # left than its LEF. Add its full extent to the in-memory
                    # pin abstract so routing respects the actual mask edge.
                    # Source LEF, GDS and verification decks are untouched.
                    odb::dbBox_create $pin $layer \
                        [expr {[$box xMin] - $extra}] [$box yMin] \
                        [$box xMax] [$box yMax]
                    incr count
                }
            }
        }
        if {$count == 0} {
            error "No matching metal pin shape for CP8D abstract correction"
        }
        # Every instance shares the master; correct it once per fresh CTS DB.
        break
    }
    puts "CP8D routing pin abstract: $count shape(s) extended to GDS extent"
    return $count
}

proc scl_add_cell_via_keepouts {} {
    global scl
    set block [ord::get_db_block]
    set cut_layer [[$block getTech] findLayer $scl(cut_layer)]
    if {$cut_layer eq "NULL" || $cut_layer eq ""} {
        error "Missing CP8D cut layer: $scl(cut_layer)"
    }
    set protected_masters [dict create]
    set count 0
    foreach inst [$block getInsts] {
        set master [$inst getMaster]
        set name [$master getName]
        if {![dict exists $protected_masters $name]} {
            set has_poly 0
            foreach obs [$master getObstructions] {
                set layer [$obs getTechLayer]
                if {$layer ne "NULL" && $layer ne "" &&
                    [$layer getName] eq $scl(poly_layer)} {
                    set has_poly 1
                    break
                }
            }
            dict set protected_masters $name $has_poly
        }
        if {![dict get $protected_masters $name]} {
            continue
        }
        # Block only new routing cuts in gate interiors. The existing pin
        # vias stay in the library. Both routing metals remain available;
        # layer changes use whitespace / the empty alternating rows.
        # The placed bbox already accounts for instance rotation/reflection.
        # Coordinates are OpenDB units, not microns.
        set box [$inst getBBox]
        odb::dbObstruction_create $block $cut_layer \
            [$box xMin] [$box yMin] [$box xMax] [$box yMax]
        incr count
    }
    if {$count == 0} {
        error "No poly-bearing cells found; cannot establish CP8D via keepouts"
    }
    puts "CP8D via keepouts: $count poly-bearing cell interiors protected"
    return $count
}
