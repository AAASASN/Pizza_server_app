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
    func createHandler (_ req: Request) throws -> EventLoopFuture<Banner> {
        let banner = try req.content.decode (Banner.self)
        return banner.save(on: req.db).map { banner }
    }
    
    // MARK: CRUD - Retrieve (Получение всех данных из базы)
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Banner]> {
        Banner.query(on: req.db) .all()
    }

    // MARK: CRUD - Retrieve (Получение одного обеда по ID)
    func getHandler(_ req: Request) -> EventLoopFuture<Banner> {
        Banner.find(req.parameters.get("bannerID"), on: req.db)
            .unwrap(or: Abort(.notFound) )
    }

    // MARK: CRUD - Update (изменение одного обеда по ID)
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Banner> {

        let updatedBanner = try req.content.decode(Banner.self)

        return Banner.find(
            req.parameters.get("bannerID"),
            on: req.db)
        .unwrap(or: Abort(.notFound)).flatMap { banner in
            banner.appId = updatedBanner.appId
            banner.image = updatedBanner.image
            return banner.save(on: req.db).map { banner }
        }
    }

    // MARK: CRUD - Delete (удаление одного обеда по ID)
    func deleteHandler(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        Banner.find(req.parameters.get ("bannerID"), on: req.db)
            .unwrap (or: Abort (.notFound))
            .flatMap { banner in banner.delete (on: req.db)
                    .transform(to: .noContent)

            }
    }
}

