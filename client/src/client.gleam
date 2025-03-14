import client/layout
import client/message.{type Message, ChangeColor}
import client/model.{type Model, Markdown, Root}
import client/view/markdown
import client/view/root.{White}
import gleam/dynamic
import gleam/dynamic/decode
import gleam/json
import gleam/list
import gleam/result
import lustre
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import plinth/browser/document
import plinth/browser/element as browser_element

pub fn main() {
  let json =
    document.query_selector("#model")
    |> result.map(browser_element.inner_text)

  let model_result = case json {
    Ok(text) ->
      json.decode(text, fn(dyn) {
        decode.run(dyn, model.model_decoder())
        |> result.map_error(fn(errs) {
          errs
          |> list.map(fn(err) {
            case err {
              decode.DecodeError(a, b, c) -> dynamic.DecodeError(a, b, c)
            }
          })
        })
      })
    _ -> Error(json.UnexpectedEndOfInput)
  }

  let app =
    lustre.application(
      fn(_) {
        case model_result {
          Ok(model) -> #(model, effect.none())
          _ -> init()
        }
      },
      update,
      view,
    )
  let assert Ok(_) = lustre.start(app, "#app", Nil)
}

pub fn init() -> #(model.Model, Effect(Message)) {
  #(Root(White), effect.none())
}

pub fn update(model: Model, message: Message) -> #(Model, Effect(Message)) {
  case model, message {
    Root(color), ChangeColor -> #(Root(root.update(color)), effect.none())
    _, _ -> #(model, effect.none())
  }
}

pub fn view(model: Model) -> Element(Message) {
  html.div([], [
    layout.header(),
    html.div([], case model {
      Root(color) -> root.view(color)
      Markdown(content) -> markdown.view(content)
    }),
    layout.footer(),
  ])
}
