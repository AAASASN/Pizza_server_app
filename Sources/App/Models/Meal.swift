//
//  Meal.swift
//
//
//  Created by Александр Мараенко on 20.04.2023.
//

import Vapor
import Fluent

final class Meal: Model {
    
    static var schema: String = "meals"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "appId")
    var appId: Int

    @Field(key: "name")
    var name: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "priceFrom")
    var priceFrom: Int
    
    @Field(key: "categoryId")
    var categoryId: Int
    
    @Field(key: "categoryName")
    var categoryName: String
    
    @Field(key: "image")
    var image: String
    
    init() { }

    init(id: UUID? = nil, appId: Int, name: String, description: String, priceFrom: Int, categoryID: Int, categoryName: String, image: String) {

        self.id = id
        self.appId = appId
        self.name = name
        self.description = description
        self.priceFrom = priceFrom
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.image = image
    }
}

extension Meal: Content { }
