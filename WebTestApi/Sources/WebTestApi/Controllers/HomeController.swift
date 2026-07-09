import Fluent
import Vapor

struct HomeController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let homes = routes.grouped("homes")
        homes.post(use: self.create)
    }
    
    @Sendable
    func create(req: Request) async throws -> HTTPStatus {
        let homeDTO = try req.content.decode(HomeDTO.self)
        
        
        let home = homeDTO.homeModel()
        try await home.save(on: req.db)
        
        return .created
    }
}
