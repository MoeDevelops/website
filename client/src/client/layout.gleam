import client/icon
import gleam/json.{type Json}
import lucide_lustre
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn base(content: Element(a), model: Json) -> Element(a) {
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
      html.title([], "Very cool website"),
      html.link([
        attribute.href("/favicon.svg"),
        attribute.type_("image/svg+xml"),
        attribute.rel("icon"),
      ]),
      html.link([
        attribute.href("/client/client.min.css"),
        attribute.type_("text/css"),
        attribute.rel("stylesheet"),
      ]),
      html.script(
        [attribute.src("/client/client.min.mjs"), attribute.type_("module")],
        "",
      ),
      html.script(
        [attribute.type_("application/json"), attribute.id("model")],
        model
          |> json.to_string(),
      ),
    ]),
    html.body([attribute.class("dark:bg-black dark:text-white")], [
      html.div([attribute.id("app")], [content]),
    ]),
  ])
}

pub fn header() -> Element(a) {
  html.header([], [])
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
