//
//  DataClassController.swift
//  
//
//  Created by Александр Мараенко on 29.04.2023.
//

import Foundation
import Fluent
import Vapor

struct DataClassController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let dataClass = routes.grouped("api", "dataClass")
        
        dataClass.get(use: getAllHandler)
        dataClass.post(use: createHandler)
        //        todos.group(":dataClass") { todo in
        //            todo.delete(use: delete)
        //        }
    }
    
    func getAllHandler(req: Request) async throws -> [DataClass] {
        try await DataClass.query(on: req.db)
            .with(\.$meals)
            .with(\.$categories)
            .with(\.$banners)
            .all()
    }
    
    func createHandler(req: Request) async throws -> DataClass {
        
        print("")
        print(req)
        print("")
        
        let dataClass = try req.content.decode(DataClass.self)
        
//        else {
//            print("")
//            print("не удалось декодировать req в dataClass")
//            print("")
//        }
        
        print("")
        print(dataClass)
        print("")

        try await dataClass.save(on: req.db)
        
        return dataClass
    }
    
    //    func delete(req: Request) async throws -> HTTPStatus {
    //        guard let todo = try await Todo.find(req.parameters.get("todoID"), on: req.db) else {
    //            throw Abort(.notFound)
    //        }
    //        try await todo.delete(on: req.db)
    //        return .noContent
    //    }
    
}
