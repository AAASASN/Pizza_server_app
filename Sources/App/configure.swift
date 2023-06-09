import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
@available(iOS 13.0.0, *)
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "rest_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "rest_password",
        database: Environment.get("DATABASE_NAME") ?? "rest_database"
    ), as: .psql)
    
    app.migrations.add(CreateMeal())
    app.migrations.add(CreateBanner())
    app.migrations.add(CreateCategory())

    try await app.autoMigrate().get()

    // register routes
    try routes(app)
}
