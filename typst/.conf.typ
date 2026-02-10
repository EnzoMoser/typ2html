#let conf(doc) = {
  // Style
  html.link(
    rel: "stylesheet",
    href: "/style.css",
  )
  // Directory outline
  let content = toml(".content.toml")
  let show_content() = {
    let table1 = ()
    if content.home != "" {
      table1.push(
        link(content.home, "/ (home)")
      )
    }
    if content.up_dir != "" {
      table1.push(
        link("..", ".. ("+content.up_dir+")")
      )
    }
    let table2 = ()
    for subdir in content.subdirs {
      table2.push(link(subdir))
    }
    if table1 != () {
      table(
        columns:1,
        ..table1.flatten()
      )
      linebreak()
    }
    if table2 != () {
      table(
        columns:1,
        ..table2.flatten()
      )
      linebreak()
    }
  }
  // Set the title
  set document(
    title: content.title
  )
  // Render math correctly
  show math.equation.where(block: false): it => {
    if target() == "html" {
      html.elem("span", attrs: (role: "math"), html.frame(it))
    } else {
      it
    }
  }
  show math.equation.where(block: true): it => {
    if target() == "html" {
      html.elem("figure", attrs: (role: "math"), html.frame(it))
    } else {
      it
    }
  }
  show_content()
  title()
  // Show rest of document
  doc
}
