#!/usr/bin/env fish

set -l out_root "./html"
set -l src_root "./typst"

# Walk all directories under ./html
find "$out_root" -type d -print0 | while read -lz hdir
    # Skip the root ./html itself
    test "$hdir" = "$out_root"; and continue

    # Corresponding source directory (strip ./html prefix, replace with ./typst)
    set -l src_dir (string replace -r '^\.\/html' "$src_root" "$hdir")

    # If no index.typ exists in the source dir, remove the html dir
    if not test -f "$src_dir/index.typ"
        rm -rf -- "$hdir"
    end
end
