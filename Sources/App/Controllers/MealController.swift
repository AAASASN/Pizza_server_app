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
    
    // CRUD - Retrieve (Получение всех данных из базы)
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Meal]> {
        Meal.query(on: req.db).all()
    }

    // CRUD - Retrieve (Получение одного обеда по ID)
    func getHandler(_ req: Request) -> EventLoopFuture<Meal> {
        Meal.find(req.parameters.get("mealID"), on: req.db)
            .unwrap(or: Abort(.notFound) )
    }

    // CRUD - Create (Добавление в базу данных одного обеда)
    func createHandler (_ req: Request) throws -> EventLoopFuture<Meal> {
        let meal = try req.content.decode(Meal.self)
        return meal.save(on: req.db).map { meal }
    }

    // CRUD - Update (изменение одного обеда по ID)
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Meal> {

        let updatedMeal = try req.content.decode(Meal.self)

        return Meal.find(
            req.parameters.get("mealID"),
            on: req.db)
        .unwrap(or: Abort(.notFound)).flatMap { meal in
            meal.appId = updatedMeal.appId
            meal.name = updatedMeal.name
            meal.description = updatedMeal.description
            meal.priceFrom = updatedMeal.priceFrom
            meal.categoryId = updatedMeal.categoryId
            meal.categoryName = updatedMeal.categoryName
            meal.image = updatedMeal.image
            return meal.save(on: req.db).map { meal }
        }
    }

    // CRUD - Delete (удаление одного обеда по ID)
    func deleteHandler(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        Meal.find(req.parameters.get("mealID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { meal in meal.delete(on: req.db)
                    .transform(to: .noContent)

            }

    }
}
