# Dump what KLayout's LVS could not match. Run from the project folder:
#   klayout -b -r scripts/lvs_diag.py
# Set LVSDB_PATH to diagnose a report other than verify/doorbell_chip.lvsdb.
import os
try:
    import klayout.db as db
except ImportError:
    import pya as db

def val(o, name):
    a = getattr(o, name)
    return a() if callable(a) else a

def nm(o):
    if o is None:
        return "-"
    try:
        return str(val(o, "name") or val(o, "expanded_name"))
    except Exception:
        try:
            return str(val(o, "expanded_name"))
        except Exception:
            return "?"

STATUS = {0: "None", 1: "Match", 2: "NoMatch", 3: "Skipped", 4: "MatchWithWarning", 5: "Mismatch"}
def st(o):
    try:
        return STATUS.get(int(val(o, "status")), "?")
    except Exception:
        return "?"

def run(lvs, limit=40):
    x = val(lvs, "xref")
    if x is None:
        print("The lvsdb has no cross reference section."); return
    print("circuits in cross reference:", val(x, "circuit_count"))
    for cp in x.each_circuit_pair():
        print("circuit  layout=%-18s schematic=%-18s %s" % (nm(val(cp, "first")), nm(val(cp, "second")), st(cp)))
    for cp in x.each_circuit_pair():
        if st(cp) == "Match":
            continue
        print("\n== circuit %s (%s) ==" % (nm(val(cp, "first")), st(cp)))
        for title, it in (("pins", x.each_pin_pair(cp)), ("nets", x.each_net_pair(cp)),
                          ("devices", x.each_device_pair(cp)), ("subcircuits", x.each_subcircuit_pair(cp))):
            rows = [(nm(val(p, "first")), nm(val(p, "second")), st(p)) for p in it]
            bad = [r for r in rows if r[2] != "Match"]
            print("%s: %d total, %d not matched" % (title, len(rows), len(bad)))
            for r in bad[:limit]:
                print("   layout %-34s schematic %-34s %s" % r)

if __name__ == "__main__":
    lvs = db.LayoutVsSchematic()
    lvs.read(os.environ.get("LVSDB_PATH", "verify/doorbell_chip.lvsdb"))
    run(lvs)
