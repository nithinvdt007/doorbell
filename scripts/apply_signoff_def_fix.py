#!/usr/bin/env python3
"""Apply the measured, geometry-only CP8D signoff edits to a routed DEF.

The edits are scoped to the named VDD and rst_n_c net blocks and are
idempotent. If the router changes the expected geometry, this script stops
instead of silently editing a different shape.
"""
from pathlib import Path
import sys


def patch_net_block(text: str, section_marker: str, net_marker: str,
                    edits: list[tuple[str, str]]) -> str:
    section_start = text.find(section_marker)
    if section_start < 0:
        raise ValueError(f"missing DEF section {section_marker!r}")
    block_start = text.find(net_marker, section_start)
    if block_start < 0:
        raise ValueError(f"missing net block {net_marker!r}")
    block_end = text.find("\n    - ", block_start + len(net_marker))
    if block_end < 0:
        end_marker = "\nEND "
        block_end = text.find(end_marker, block_start)
    if block_end < 0:
        raise ValueError(f"could not find end of {net_marker!r}")

    block = text[block_start:block_end]
    for old, new in edits:
        old_count = block.count(old)
        new_count = block.count(new)
        if old_count == 1 and new_count == 0:
            block = block.replace(old, new, 1)
        elif old_count == 0 and new_count == 1:
            continue  # already fixed
        else:
            raise ValueError(
                f"expected one old or one fixed shape in {net_marker!r}; "
                f"found old={old_count}, fixed={new_count}: {old}"
            )
    return text[:block_start] + block + text[block_end:]


def main() -> int:
    path = Path(sys.argv[1] if len(sys.argv) > 1 else "results/route.def")
    with path.open("r", encoding="utf-8", newline="") as stream:
        text = stream.read()

    vdd_edits = [
        (
            f"NEW metal1 7000 + SHAPE FOLLOWPIN ( 596800 {y} ) ( 2402300 {y} )",
            f"NEW metal1 7000 + SHAPE FOLLOWPIN ( 585600 {y} ) ( 2413500 {y} )",
        )
        for y in (1090050, 1140750, 1799850, 1850550)
    ]
    reset_edits = [
        ("NEW metal2 ( 1480050 1461500 ) ( * 1472600 0 )",
         "NEW metal2 ( 1480750 1461500 ) ( * 1472600 0 )"),
        ("NEW metal2 ( 1339650 1461500 ) ( * 1472600 0 )",
         "NEW metal2 ( 1340350 1461500 ) ( * 1472600 0 )"),
    ]

    text = patch_net_block(text, "SPECIALNETS ", "    - VDD (", vdd_edits)
    text = patch_net_block(text, "\nNETS ", "    - rst_n_c (", reset_edits)
    with path.open("w", encoding="utf-8", newline="") as stream:
        stream.write(text)
    print(f"Applied/confirmed CP8D signoff geometry in {path}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, ValueError) as exc:
        print(f"signoff DEF patch failed: {exc}", file=sys.stderr)
        raise SystemExit(1)

