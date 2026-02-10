#!/usr/bin/env fish

function list_subdirs
    # One level of subdirs, names only, sorted; excludes "." and hidden dirs.
    for p in ./*
        if test -d "$p"
            set name (basename "$p")
            if not string match -q '.*' -- "$name"
                echo "$name"
            end
        end
    end | sort
end

function gen_toml --argument-names title home up_dir
    test -f index.typ; or return
    set subdirs (list_subdirs)

    echo "title = \"$title\"" >.content.toml
    echo "home = \"$home\"" >>.content.toml
    echo "up_dir = \"$up_dir\"" >>.content.toml
    echo "subdirs = [" >>.content.toml
    for d in $subdirs
        if test -f "$d/index.typ"
            echo "  \"$d\"," >>.content.toml
        end
    end
    echo "]" >>.content.toml
end

function repeat_dfs --argument-names depth parent_name
    # Build "../.." for current depth (0 => "", 1 => "..", 2 => "../..", ...)
    set home ""
    if test $depth -gt 0
        set home (string join "/" (for i in (seq 1 $depth); echo ".."; end))
    end

    if contains "$home" ""
        set title home
    else
        set title (basename (pwd -P))
    end

    gen_toml "$title" "$home" "$parent_name"

    if not contains "$home" ""
        set parent_name (basename (pwd -P))
    else
        set parent_name ""
    end

    for d in (list_subdirs)
        if test -f "$d/index.typ"
            cd "$d"
            repeat_dfs (math $depth + 1) "$parent_name"
            cd ..
        end
    end
end

cd typst
repeat_dfs 0 ""
cd ..
