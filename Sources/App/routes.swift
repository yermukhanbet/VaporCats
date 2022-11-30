import Vapor

func routes(_ app: Application) throws {

  let cats = app.grouped("cat")

  cats.on(.GET, "fact") { request in
    return "Cats are great creatures"
  }

  cats.get("color", ":color") { request in
    guard let color = request.parameters.get("color"),
          let type = CatTypes(rawValue: color) else {
      return "Could not find the cat type. Sorry"
    }

    return "Your cat's type is: \(type)"
  }.description("Returns the type of your cat based on the color")

  app.get { req async in
    "It works!"
  }

  app.get("hello") { req async -> String in
    "Hello, world!"
  }

  app.get("greeting", ":name") { request -> String in
    guard let name = request.parameters.get("name") else {
      return "sorry, no name was found. Try again"
    }
    return "Hey, \(name)"
  }.description("Greets the person with the dynamic name")
}

public enum CatTypes: String {
  case smol = "brown"
  case big = "black"
}
