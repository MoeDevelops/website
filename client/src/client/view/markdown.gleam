import lustre/attribute
import lustre/element/html
import lustre/ssg/djot

pub fn view(content: String) {
  [
    html.div(
      [attribute.class("[&>*]:my-2 [&>h1]:text-6xl [&>h2]:text-4xl")],
      djot.render(content, djot.default_renderer()),
    ),
  ]
}
