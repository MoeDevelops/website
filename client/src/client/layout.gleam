import client/icon
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
      html.meta([attribute.name("description"), attribute.content("Personal website for MoeDevelops")]),
      html.meta([attribute.name("darkreader-lock")]),
      html.title([], "Client"),
      html.link([
        attribute.href(
          "https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css",
        ),
        attribute.rel("stylesheet"),
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
    ]),
    html.body([attribute.class("dark:bg-black dark:text-white")], [
      html.div([attribute.id("app")], [content]),
    ]),
  ])
}

pub fn footer() -> Element(a) {
  html.footer([], [
    icon.link(
      "lab la-github text-6xl",
      "https://github.com/MoeDevelops/website",
      "Link to GitHub"
    ),
  ])
}
