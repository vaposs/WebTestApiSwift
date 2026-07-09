import Fluent

struct CreateHome: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("homes")
            .id()
            .field("address", .string, .required)
            .field("city", .string, .required)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("homes").delete()
    }
}
