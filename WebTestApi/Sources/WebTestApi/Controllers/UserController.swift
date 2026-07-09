import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let users = routes.grouped("register")
        users.post(use: self.create)
    }

    @Sendable
    func create(req: Request) async throws -> HTTPStatus {
        let userDTO = try req.content.decode(UserDTO.self)
        
        // Проверка на существующего пользователя
        let existingUser = try await User.query(on: req.db)
            .filter(\.$login == userDTO.login)
            .first()
        
        if existingUser != nil {
            throw Abort(.conflict, reason: "Пользователь с таким логином уже существует")
        }

        let user = userDTO.userModel()
        try await user.save(on: req.db)
            
        return .created
    }
}
