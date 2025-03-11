import client
import client/layout
import gleam/http/request
import gleam/http/response
import lustre/element
import mist
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
  use <- wisp.serve_static(req, "/static", priv <> "/static")

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
    [] -> build_lustre(client.view)
    _ -> wisp.not_found() |> wisp.string_body("Not found")
  }
}

fn build_lustre(
  view: fn(client.Model) -> element.Element(client.Message),
) -> Response {
  wisp.ok()
  |> wisp.html_body(
    client.init().0
    |> view()
    |> layout.base()
    |> element.to_document_string_builder(),
  )
}
