import client
import client/layout
import client/model.{type Model, Markdown}
import gleam/http/request
import gleam/http/response
import gleam/option.{type Option, None, Some}
import gleam/result
import lustre/element
import mist
import server/blog
import server/context.{type Context}
import wisp.{type Request, type Response}
import wisp/wisp_mist

fn middleware(
  req: wisp.Request,
  handle_request: fn(Request) -> Response,
) -> wisp.Response {
  let req = wisp.method_override(req)
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use req <- wisp.handle_head(req)
  let assert Ok(priv) = wisp.priv_directory("client")
  use <- wisp.serve_static(req, "/", priv <> "/static")

  handle_request(req)
}

pub fn handle_request(
  req: request.Request(mist.Connection),
  ctx: Context,
  secret_key_base: String,
) -> response.Response(mist.ResponseData) {
  case request.path_segments(req) {
    _ -> wisp_mist.handler(handle_request_wisp(_, ctx), secret_key_base)(req)
  }
}

fn handle_request_wisp(req: Request, _ctx: Context) -> Response {
  use req <- middleware(req)
  case wisp.path_segments(req) {
    [] -> build_lustre(None)
    ["blog", entry] ->
      blog.get(entry)
      |> result.map(fn(content) { Some(Markdown(content)) })
      |> result.map(build_lustre)
      |> result.unwrap_both()
    _ -> wisp.not_found() |> wisp.string_body("Not found")
  }
}

fn build_lustre(model_option: Option(Model)) -> Response {
  let model =
    model_option
    |> option.unwrap(client.init().0)

  wisp.ok()
  |> wisp.html_body(
    model
    |> client.view()
    |> layout.base(model.encode_model(model))
    |> element.to_document_string_builder(),
  )
}
