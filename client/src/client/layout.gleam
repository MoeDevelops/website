import client/icon
import lucide_lustre
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn base(content: Element(a)) -> Element(a) {
  html.html([attribute.attribute("lang", "en")], [
    html.head([], [
      html.meta([attribute.attribute("charset", "UTF-8")]),
      html.meta([
        attribute.attribute("content", "width=device-width, initial-scale=1.0"),
        attribute.name("viewport"),
      ]),
      html.meta([
        attribute.name("description"),
        attribute.content("Personal website for MoeDevelops"),
      ]),
      html.meta([attribute.name("darkreader-lock")]),
      html.title([], "Client"),
      html.link([
        attribute.href("/client/client.min.css"),
        attribute.type_("text/css"),
        attribute.rel("stylesheet"),
      ]),
      html.script(
        [attribute.src("/client/client.min.mjs"), attribute.type_("module")],
        "",
      ),
    ]),
    html.body([attribute.class("dark:bg-black dark:text-white")], [
      html.div([attribute.id("app")], [content]),
    ]),
  ])
}

pub fn footer() -> Element(a) {
  html.footer([], [
    icon.link(
      lucide_lustre.github,
      "https://github.com/MoeDevelops/website",
      "GitHub",
    ),
  ])
}
