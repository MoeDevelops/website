import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn link(
  icon: fn(List(Attribute(a))) -> Element(a),
  link: String,
  alt: String,
) -> Element(a) {
  html.a(
    [
      attribute.href(link),
      attribute.attribute("aria-label", alt),
      attribute.target("_blank"),
    ],
    [icon([attribute.alt(alt), attribute.class("w-12 h-12")])],
  )
}
