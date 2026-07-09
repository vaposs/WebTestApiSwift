import Fluent
import struct Foundation.UUID

final class Home: Model, @unchecked Sendable {
    static let schema = "homes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "address")
    var address: String
    
    @Field(key: "city")
    var city: String
    
    init() { }
    
    init(id: UUID? = nil, address: String, city: String)
    {
        self.id = id
        self.address = address
        self.city = city
    }
    
    func homeDTO() -> HomeDTO {
        .init(
            id: self.id,
            address: self.address,
            city: self.city)
    }
}
