#!/usr/bin/env fish

cd typst
for dir in (find . -type d)
    set index "$dir/index.typ"
    set link "$dir/.conf.typ"

    if test -f "$index"
        # compute relative path from $dir to root/conf.typ
        set depth (string split "/" (string trim -c "./" -- "$dir") | count)
        if test $depth -eq 0
            set rel ".conf.typ"
        else
            set rel (string repeat -n $depth "../")".conf.typ"
        end

        if test -L "$link"
            rm "$link"
        end
        ln -s "$rel" "$link"
    else
        if test -L "$link"
            rm "$link"
        end
    end
end
cd ..
