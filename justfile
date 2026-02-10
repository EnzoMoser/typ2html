set shell := ["fish", "-c"]

# Watch and update specific directory
watch input=".":
    typst watch --features html --no-serve "{{input}}/index.typ" "html/index.html"

# Run a local server to test the html
host:
    python3 -m http.server 1102 -d html

# Compile the `typst/` dir into `html/`
[default]
compile:
    # Make the `html/` directory and symlink `style.css` inside it
    mkdir -p html
    test -e html/style.css || ln -s ../style.css html/style.css
    # Recursively create symlinks to `.conf.typ` inside every folder in `typst/` that contains `index.typ`
    # Cleanup/remove `.conf.typ` symlinks that don't have `index.typ` in the same dir
    functions/gen_symlinks.fish
    # Recursively create a `.content.toml` file that lists subdirectories that have `index.typ` in `typst/`
    # Cleanup/remove `.content.toml` files that don't have `index.typ` in the same dir
    functions/gen_content.fish
    # Recursively compile each `index.typ` inside `typst/` into `index.html` inside `html/`
    functions/gen_html.fish
    # Remove files and folders from `html/` that aren't in `typst/`
    functions/clean_html.fish
