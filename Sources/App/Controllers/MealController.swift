//
//  MealController.swift
//  
//
//  Created by Александр Мараенко on 21.04.2023.
//

import Vapor
import Fluent

struct MealController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let mealsRoutes = routes.grouped("api", "meals")
        
        mealsRoutes.get(use: getAllHandler)
        mealsRoutes.get (":mealID", use: getHandler)
        mealsRoutes.post(use: createHandler)
        mealsRoutes.put (":mealID", use: updateHandler)
        mealsRoutes.delete(":mealID", use: deleteHandler)
    }
    
    //MARK: CRUD - Create (Добавление в базу данных одного обеда)
    func createHandler (_ req: Request) async throws -> Meal {
        guard let meal = try? req.content.decode(Meal.self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не получилось декодировать контент в модель Meal"))
        }
        try await meal.save(on: req.db)
        return meal
    }
    
    //MARK: CRUD - Retrieve (Получение всех данных из базы)
    func getAllHandler(_ req: Request) async throws -> [Meal] {
        try await Meal.query(on: req.db).all()
    }

    // MARK: CRUD - Retrieve (Получение одного обеда по ID)
    func getHandler(_ req: Request) async throws -> Meal {
        guard let meal = try await Meal.find(req.parameters.get("mealID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return meal
    }



    // CRUD - Update (изменение одного обеда по ID)
    func updateHandler(_ req: Request) async throws -> Meal {

        let updatedMeal = try req.content.decode(Meal.self)
        
        guard let meal = try await Meal.find(
            req.parameters.get("mealID"),
            on: req.db) else {
            throw Abort(.notFound)
        }
        
        meal.appId = updatedMeal.appId
        meal.name = updatedMeal.name
        meal.description = updatedMeal.description
        meal.priceFrom = updatedMeal.priceFrom
        meal.categoryId = updatedMeal.categoryId
        meal.categoryName = updatedMeal.categoryName
        meal.image = updatedMeal.image
        try await meal.save(on: req.db)
        return meal
    }

    // CRUD - Delete (удаление одного обеда по ID)
    func deleteHandler(_ req: Request) async throws ->  HTTPStatus {
        guard let meal = try await Meal.find(req.parameters.get ("mealID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await meal.delete(on: req.db)
        return .noContent

    }
}
