import Fluent
import struct Foundation.UUID

final class User: Model, @unchecked Sendable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "login")
    var login: String
    
    @Field(key: "password")
    var password: String

    init() { }

    init(id: UUID? = nil, login: String, password: String) {
        self.id = id
        self.login = login
        self.password = password
    }
    
    func userDTO() -> UserDTO {
        .init(
            id: self.id,
            login: self.$login.value!,
            password: self.$password.value!
        )
    }
}
