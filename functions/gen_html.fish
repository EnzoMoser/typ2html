#!/usr/bin/env fish

set -l src_root typst
set -l out_root html

# Find all index.typ files under typst/, excluding anything under html/
find "$src_root" -type f -name "index.typ" -print0 | while read -lz f
    # Path relative to typst/ (strip leading "typst/")
    set -l rel (string replace -r "^$src_root\/" '' -- "$f")

    # Directory containing index.typ (relative to typst/)
    set -l dir (path dirname -- "$rel")

    # Mirror directory under html/
    set -l out_dir "$out_root/$dir"
    mkdir -p -- "$out_dir"

    # Output path: html/<same dir>/index.html
    set -l out_html "$out_dir/index.html"

    # Compile
    set cmd "typst compile --features html \"$src_root/$rel\" \"$out_html\""
    echo $cmd
    eval $cmd
end
