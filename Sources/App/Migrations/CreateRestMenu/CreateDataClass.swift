//
//  DataClass.swift
//  
//
//  Created by Александр Мараенко on 28.04.2023.
//

import Foundation
import Fluent

struct CreateDataClass: AsyncMigration {
    
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema("dataClass")
        
            .id()
//            .field("appId", .int, .required)
//            .field("image", .string, .required)
//            .field("dataClass_id", .uuid, .references("dataClass", "id"))
            .create()
        
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("banners").delete()
    }

}
