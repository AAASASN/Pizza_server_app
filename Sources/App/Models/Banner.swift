//
//  Banner.swift
//  
//
//  Created by Александр Мараенко on 24.04.2023.
//

import Foundation
import Vapor
import Fluent

// MARK: - Banner
final class Banner: Model {
    
    static var schema: String = "banners"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "appId")
    var appId: Int
    
    @Field(key: "image")
    var image: String
    
    // Reference to the DataClass this Banner is in.
    @Parent(key: "dataClass_id")
    var dataClass: DataClass

    init() { }

    init(id: UUID? = nil, appId: Int, image: String, dataClassID: UUID) {
        self.id = id
        self.appId = appId
        self.image = image
        
        self.$dataClass.id = dataClassID
    }
}

extension Banner: Content { }
