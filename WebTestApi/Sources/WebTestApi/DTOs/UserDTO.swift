import Fluent
import Vapor

struct  UserDTO: Content {
    var id: UUID?
    var login: String
    var password: String
    
    func userModel() -> User {
        return User(id: id, login: login, password: password)
    }
}
