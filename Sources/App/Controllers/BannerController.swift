//
//  BannerController.swift
//  
//
//  Created by Александр Мараенко on 24.04.2023.
//

import Vapor
import Fluent

struct BannerController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        let bannersRoutes = routes.grouped("api", "banners")
        
        bannersRoutes.get(use: getAllHandler)
        bannersRoutes.get (":bannerID", use: getHandler)
        bannersRoutes.post(use: createHandler)
        bannersRoutes.put (":bannerID", use: updateHandler)
        bannersRoutes.delete(":bannerID", use: deleteHandler)
    }
    
    // MARK: CRUD - Create (Добавление в базу данных одного обеда)
    func createHandler (_ req: Request) async throws -> Banner {
        guard let banner = try? req.content.decode (Banner.self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не получилось декодировать контент в модель Banner"))
        }
        try await banner.save(on: req.db)
        return banner
    }
    
    // MARK: CRUD - Retrieve (Получение всех данных из базы)
    func getAllHandler(_ req: Request) async throws -> [Banner] {
        try await Banner.query(on: req.db).all()
    }

    // MARK: CRUD - Retrieve (Получение одного обеда по ID)
    func getHandler(_ req: Request) async throws -> Banner {
        guard let banner = try await Banner.find(req.parameters.get("bannerID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return banner
    }

    // MARK: CRUD - Update (изменение одного обеда по ID)
    func updateHandler(_ req: Request) async throws -> Banner {
        let updatedBanner = try req.content.decode(Banner.self)
        guard let banner = try await Banner.find(req.parameters.get("bannerID"), on: req.db) else {
            throw Abort(.notFound)
        }
        banner.appId = updatedBanner.appId
        banner.image = updatedBanner.image
        try await banner.save(on: req.db)
        return banner
    }

    // MARK: CRUD - Delete (удаление одного обеда по ID)
    func deleteHandler(_ req: Request) async throws ->HTTPStatus {
        guard let banner = try await Banner.find(req.parameters.get ("bannerID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await banner.delete(on: req.db)
        return .noContent
        
    }
}

