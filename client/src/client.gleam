import client/layout
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
            White -> "dark:text-white"
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
          "dark:bg-white dark:hover:bg-gray-300 dark:text-black bg-black hover:bg-gray-800 text-white font-bold py-2 px-4 rounded",
        ),
      ],
      [html.text("Change color")],
    ),
    layout.footer(),
  ])
}
