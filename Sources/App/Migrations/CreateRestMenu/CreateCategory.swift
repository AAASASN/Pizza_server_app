//
//  CreateCategory.swift
//  
//
//  Created by Александр Мараенко on 25.04.2023.
//

import Fluent

struct CreateCategory: AsyncMigration {
    
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema("categories")
            .id()
            .field("appId", .int, .required)
            .field("name", .string, .required)
        
            .field("dataClass_id", .uuid, .required, .references("dataClass", "id"))
        
            .create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("categories").delete()
    }
    
}
