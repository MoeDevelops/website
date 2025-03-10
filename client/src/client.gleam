import client/icon
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

pub fn main() {
  let app = lustre.application(fn(_) { init() }, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
}

// Equivalent of index.html in lustre elements
pub fn base(content: element.Element(a)) -> element.Element(a) {
  html.html([attribute.attribute("lang", "en")], [
    html.head([], [
      html.meta([attribute.attribute("charset", "UTF-8")]),
      html.meta([
        attribute.attribute("content", "width=device-width, initial-scale=1.0"),
        attribute.name("viewport"),
      ]),
      html.meta([attribute.name("darkreader-lock")]),
      html.title([], "Client"),
      html.link([
        attribute.href(
          "https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css",
        ),
        attribute.rel("stylesheet"),
      ]),
      html.link([
        attribute.href("/static/client.css"),
        attribute.type_("text/css"),
        attribute.rel("stylesheet"),
      ]),
      html.script(
        [attribute.src("/static/client.mjs"), attribute.type_("module")],
        "",
      ),
    ]),
    html.body([attribute.class("bg-black text-white")], [
      html.div([attribute.id("app")], [content]),
    ]),
  ])
}

pub type Model {
  Model(color: Color)
}

pub type Color {
  White
  Red
  Blue
  Yellow
}

pub type Message {
  ChangeColor
}

pub fn init() -> #(Model, Effect(Message)) {
  #(Model(White), effect.none())
}

pub fn update(model: Model, message: Message) -> #(Model, Effect(Message)) {
  case message {
    ChangeColor -> {
      let color = case model.color {
        Blue -> Red
        Red -> White
        White -> Yellow
        Yellow -> Blue
      }

      #(Model(color), effect.none())
    }
  }
}

pub fn view(model: Model) -> Element(Message) {
  html.div([], [
    html.h1(
      [
        attribute.class(
          "text-8xl "
          <> case model.color {
            White -> "text-white"
            Blue -> "text-blue-500"
            Red -> "text-red-500"
            Yellow -> "text-yellow-500"
          },
        ),
      ],
      [html.text("Hello, World!")],
    ),
    html.h2([attribute.class("text-6xl")], [html.text("Hi :D")]),
    html.button(
      [
        event.on_click(ChangeColor),
        attribute.class(
          "bg-white hover:bg-gray-200 text-black font-bold py-2 px-4 rounded",
        ),
      ],
      [html.text("Change color")],
    ),
    footer(),
  ])
}

pub fn footer() -> Element(a) {
  html.footer([], [
    icon.link(
      "lab la-github text-6xl",
      "https://github.com/MoeDevelops/website",
    ),
  ])
}
