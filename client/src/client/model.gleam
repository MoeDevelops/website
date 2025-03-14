import client/view/root.{type Color, White}
import gleam/dynamic/decode
import gleam/json

pub type Model {
  Root(color: Color)
  Markdown(content: String)
}

pub fn model_decoder() -> decode.Decoder(Model) {
  use variant <- decode.field("type", decode.string)
  case variant {
    "root" -> {
      use color <- decode.field("color", root.color_decoder())
      decode.success(Root(color:))
    }
    "markdown" -> {
      use content <- decode.field("content", decode.string)
      decode.success(Markdown(content:))
    }
    _ -> decode.failure(Root(White), "Model")
  }
}

pub fn encode_model(model: Model) -> json.Json {
  case model {
    Root(..) ->
      json.object([
        #("type", json.string("root")),
        #("color", root.encode_color(model.color)),
      ])
    Markdown(..) ->
      json.object([
        #("type", json.string("markdown")),
        #("content", json.string(model.content)),
      ])
  }
}
