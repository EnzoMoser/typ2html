set shell := ["fish", "-c"]

watch input=".":
    typst watch --features html --no-serve "{{input}}/index.typ" "html/index.html"

[default]
compile:
    @mkdir -p html
    @test -e html/style.css || ln -s ../style.css html/style.css
    functions/gen_symlinks.fish
    functions/gen_content.fish
    functions/gen_html.fish
    functions/clean_html.fish
