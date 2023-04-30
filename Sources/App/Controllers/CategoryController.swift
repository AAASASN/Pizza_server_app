//
//  CategoryController.swift
//  
//
//  Created by Александр Мараенко on 25.04.2023.
//

import Foundation
import Vapor
import Fluent

struct CategoryController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        let categoriesRoutes = routes.grouped("api", "categories")
        
        categoriesRoutes.get(use: getAllHandler)
        categoriesRoutes.get (":categoryID", use: getHandler)
        categoriesRoutes.post(use: createHandler)
        categoriesRoutes.put (":categoryID", use: updateHandler)
        categoriesRoutes.delete(":categoryID", use: deleteHandler)
    }
    
    // MARK: CRUD - Create (Добавление в базу данных одного обеда)
    func createHandler(_ req: Request) async throws -> Category {
        guard let categories = try? req.content.decode(Category.self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не получилось декодировать контент в модель Category"))
        }
        try await categories.save(on: req.db)
        return categories
    }
    
    // MARK: CRUD - Retrieve (Получение всех данных из базы)
    func getAllHandler(_ req: Request) async throws -> [Category] {
        try await Category.query(on: req.db) .all()
    }
    
    // MARK: CRUD - Retrieve (Получение одного обеда по ID)
    func getHandler(_ req: Request) async throws -> Category {
        guard let category = try await Category.find(req.parameters.get("categoryID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return category
    }
        
    // MARK: CRUD - Update (изменение одного обеда по ID)
    func updateHandler(_ req: Request) async throws -> Category {
        
        let updatedCategory = try req.content.decode(Category.self)
        
        guard let category = try await Category.find(
            req.parameters.get("categoryID"),
            on: req.db) else {
            throw Abort(.notFound)
        }
        category.appId = updatedCategory.appId
        category.name = updatedCategory.name
        try await category.save(on: req.db)
        return category
        
    }
    
    // MARK: CRUD - Delete (удаление одного обеда по ID)
    func deleteHandler(_ req: Request) async throws -> HTTPStatus {
        guard let category = try await Category.find(req.parameters.get ("categoryID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await category.delete(on: req.db)
        return .noContent
    }

}
