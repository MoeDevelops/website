import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn link(icon_class: String, link: String, aria: String) -> Element(a) {
  html.a(
    [
      attribute.href(link),
      attribute.class(icon_class),
      attribute.target("_blank"),
      attribute.attribute("aria-label", aria)
    ],
    [],
  )
}
