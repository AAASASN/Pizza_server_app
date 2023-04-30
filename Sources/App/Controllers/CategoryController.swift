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
    
    // CRUD - Retrieve (Получение всех данных из базы)
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Category]> {
        Category.query(on: req.db) .all()
    }

    // CRUD - Retrieve (Получение одного обеда по ID)
    func getHandler(_ req: Request) -> EventLoopFuture<Category> {
        Category.find(req.parameters.get("categoryID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    // CRUD - Create (Добавление в базу данных одного обеда)
    func createHandler(_ req: Request) throws -> EventLoopFuture<Category> {
        let categories = try req.content.decode(Category.self)
        return categories.save(on: req.db).map { categories }
    }

    // CRUD - Update (изменение одного обеда по ID)
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Category> {

        let updatedCategory = try req.content.decode(Category.self)

        return Category.find(
            req.parameters.get("categoryID"),
            on: req.db)
        .unwrap(or: Abort(.notFound)).flatMap { category in
            category.appId = updatedCategory.appId
            category.name = updatedCategory.name
            return category.save(on: req.db).map { category }
        }
    }

    // CRUD - Delete (удаление одного обеда по ID)
    func deleteHandler(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        Category.find(req.parameters.get ("categoryID"), on: req.db)
            .unwrap (or: Abort(.notFound))
            .flatMap { category in category.delete(on: req.db)
                    .transform(to: .noContent)

            }
    }
}


