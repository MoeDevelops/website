import client/message.{ChangeColor}
import gleam/dynamic/decode
import gleam/json
import lustre/attribute
import lustre/element/html
import lustre/event

pub type Color {
  White
  Red
  Blue
  Yellow
  Pink
}

pub fn color_decoder() -> decode.Decoder(Color) {
  use variant <- decode.then(decode.string)
  case variant {
    "white" -> decode.success(White)
    "red" -> decode.success(Red)
    "blue" -> decode.success(Blue)
    "yellow" -> decode.success(Yellow)
    "pink" -> decode.success(Pink)
    _ -> decode.failure(White, "Color")
  }
}

pub fn encode_color(color: Color) -> json.Json {
  case color {
    White -> json.string("white")
    Red -> json.string("red")
    Blue -> json.string("blue")
    Yellow -> json.string("yellow")
    Pink -> json.string("pink")
  }
}

pub fn update(color: Color) -> Color {
  case color {
    Blue -> Red
    Red -> White
    White -> Yellow
    Yellow -> Pink
    Pink -> Blue
  }
}

pub fn view(color: Color) {
  [
    html.h1(
      [
        attribute.class(
          "text-8xl "
          <> case color {
            White -> "dark:text-white"
            Blue -> "text-blue-500"
            Red -> "text-red-500"
            Yellow -> "text-yellow-500"
            Pink -> "text-pink-500"
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
  ]
}
