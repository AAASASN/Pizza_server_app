//
//  CreateMeal.swift
//  
//
//  Created by Александр Мараенко on 20.04.2023.
//

import Fluent

struct CreateMeal: AsyncMigration {
    
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema("meals")
            .id()
            .field("appId", .int, .required)
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("priceFrom", .int, .required)
            .field("categoryId", .int, .required)
            .field("categoryName", .string, .required)
            .field("image", .string, .required)
            .create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("meals").delete()
    }

}
