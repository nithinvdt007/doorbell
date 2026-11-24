# bond pad nets (port to pad pin) are not routed: mark them special
set block [ord::get_db_block]
foreach bt [$block getBTerms] {
    set net [$bt getNet]
    if {$net ne "NULL"} { $net setSpecial }
}
