import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

/// configures your application
func configure(_ app: Application) async throws {
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    
    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "maizmalkova",
        password: Environment.get("DATABASE_PASSWORD") ?? "12345",
        database: Environment.get("DATABASE_NAME") ?? "WebTestApi",
        tls: .disable // для локальной разработки
        //tls: .prefer(try .init(configuration: .clientDefault))) // 
    )), as: .psql)

    // add migration - работа с Базой данных
    app.migrations.add(CreateUser())
    app.migrations.add(CreateHome())
    try await app.autoMigrate()
    
    // register routes
    try routes(app)
}
