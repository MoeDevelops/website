import gleam/list
import gleam/result
import gleam/string
import simplifile
import wisp.{type Response}

pub fn get(entry: String) -> Result(String, Response) {
  let result =
    {
      use dir <- result.try(get_dir())
      use files <- result.try(get_files(dir))
      Ok(files)
    }
    |> result.replace_error(wisp.internal_server_error())

  use files <- result.try(result)

  case
    list.find(files, fn(file) {
      let assert Ok(file) = string.split(file, "/") |> list.last()
      let file = string.replace(file, ".md", "")
      file == entry
    })
  {
    Ok(file) -> {
      read_file(file)
    }
    Error(_) -> Error(wisp.not_found() |> wisp.string_body("Not found"))
  }
}

fn get_dir() -> Result(String, Nil) {
  wisp.priv_directory("server")
  |> result.map(string.append(_, "/blog"))
}

fn get_files(dir: String) -> Result(List(String), Nil) {
  case simplifile.read_directory(dir) {
    Ok(files) -> Ok(files |> list.map(string.append(dir <> "/", _)))
    Error(_) -> Error(Nil)
  }
}

fn read_file(file: String) -> Result(String, Response) {
  case simplifile.read(file) {
    Ok(data) -> Ok(data)
    Error(_) -> Error(wisp.internal_server_error())
  }
}
