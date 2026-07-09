import Fluent
import Vapor

struct HomeDTO: Content {
    var id: UUID?
    var address: String
    var city: String
    
    func homeModel() -> Home {
        return Home(id: id, address: address, city: city)
    }
}
