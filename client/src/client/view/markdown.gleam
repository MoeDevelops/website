import lustre/ssg/djot

pub fn view(content: String) {
  djot.render(content, djot.default_renderer())
}
