# The selected SCL frame supplies the die dimensions. Keep the 1.8 mm core
# centered in the 3 mm frame, leaving room for the SCL pad ring and PDN.
source scripts/frame_geometry.tcl
set CORE_SIZE 1800
if {$DIE_W < $CORE_SIZE || $DIE_H < $CORE_SIZE} {
    error "SCL frame is too small for the configured ${CORE_SIZE} um core"
}
set CORE_LO [expr {($DIE_W - $CORE_SIZE) / 2.0}]
set CORE_HI [expr {$CORE_LO + $CORE_SIZE}]
set PAD_GAP 0.0

