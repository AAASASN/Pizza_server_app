//
//  RestMenu.swift
//
//
//  Created by Александр Мараенко on 26.04.2023.
//
//
//import Foundation
//
//import Fluent
//import Vapor
//
//final class RestMenu: Model, Content {
//    static let schema = "restmenu"
//    
//    @ID()
//    var id: UUID?
//
//    @Field(key: "title")
//    var title: String
//    
//    @Field(key: "someInt")
//    var someInt: Int
//    
//
//    init() { }
//
//    init(id: UUID? = nil, title: String) {
//        self.id = id
//        self.title = title
//        self.someInt = someInt
//    }
//}

//-------------------------------------------

//// MARK: - RestMenu
//struct RestMenu: Decodable {
//    let data: DataClass?
//}





//
//// MARK: - Banner
//struct Banner: Decodable {
//    let id: Int?
//    let image: String?
//}
//
//// MARK: - Category
//struct Category: Decodable {
//    let id: Int?
//    let name: String?
//}
//
//// MARK: - Menu
//struct Menu: Decodable {
////    let id: UUID?
//
//    let id: Int?
//    let name, description: String?
//    let priceFrom, categoryID: Int?
//    let categoryName: String?
//    let image: String?
//
////    enum CodingKeys: String, CodingKey {
////        case id, name, description, priceFrom
////        case categoryID = "categoryId"
////        case categoryName, image
////    }
//}
