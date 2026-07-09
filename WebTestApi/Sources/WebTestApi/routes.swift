import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async -> Response in
        return req.redirect(to: "/WebTestApi.html")
    }
    
    app.post("register") { req async throws -> HTTPStatus in
        let userDTO = try req.content.decode(UserDTO.self)
        
        // Проверка существующего пользователя
        let existingUser = try await User.query(on: req.db)
            .filter(\.$login == userDTO.login)
            .first()
        
        if existingUser != nil {
            throw Abort(.conflict, reason: "Пользователь с таким логином уже существует")
        }
        
        let user = User(id: nil, login: userDTO.login, password: userDTO.password)
        try await user.save(on: req.db)
        
        return .created
    }
    
    try app.register(collection: HomeController())
}
