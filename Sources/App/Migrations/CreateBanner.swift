//
//  CreateBanner.swift
//  
//
//  Created by Александр Мараенко on 24.04.2023.
//

import Fluent

struct CreateBanner: AsyncMigration {
    
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema("banners")
            .id()
            .field("appId", .int, .required)
            .field("image", .string, .required)
            .create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("banners").delete()
    }

}
