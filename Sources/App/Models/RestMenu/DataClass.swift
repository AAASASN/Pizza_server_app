//
//  DataClass.swift
//  
//  Created by Александр Мараенко on 28.04.2023.
//

import Foundation
import Fluent
import Vapor

// MARK: - DataClass
final class DataClass: Model {
    
    static var schema: String = "dataClass"
    
    @ID(key: .id)
    var id: UUID?
    
    @Children(for: \.$dataClass)
    var meals: [Meal]
    
    @Children(for: \.$dataClass)
    var categories: [Category]
    
    @Children(for: \.$dataClass)
    var banners: [Banner]
    
    init() {}

    init(id: UUID? = nil) { //, meals: [Meal], categories: [Category], banners: [Banner]) {
        self.id = id
        self.meals = meals
        self.categories = categories
        self.banners = banners
    }
}

extension DataClass: Content { }
