//
//  Category.swift
//  
//
//  Created by Александр Мараенко on 25.04.2023.



import Foundation
import Vapor
import Fluent

// MARK: - Category
final class Category: Model {
    
    static var schema: String = "categories"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "appId")
    var appId: Int
    
    @Field(key: "name")
    var name: String
    
    // Reference to the DataClass this Category is in.
    @Parent(key: "dataClass_id")
    var dataClass: DataClass

    init() { }

    init(id: UUID? = nil, appId: Int, name: String, dataClassID: UUID) {
        self.id = id
        self.appId = appId
        self.name = name
        
        self.$dataClass.id = dataClassID
    }
}

extension Category: Content { }
