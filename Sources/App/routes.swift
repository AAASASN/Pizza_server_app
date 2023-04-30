import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello", ":zhopa") { req async -> String in
        let zhopa = req.parameters.get("zhopa")!
        return "Hello, \(zhopa)!"
    }
    
//    app.get("dataClass") { req in
//        try await DataClass.query(on: req.db)
//            .with(\.$meals)
//            .with(\.$categories)
//            .with(\.$banners)
//            .all()
//    }
    
    
    let dataClassController = DataClassController()
    try app.register(collection: dataClassController)

    let mealsController = MealController()
    try app.register(collection: mealsController)
    
    let bannersController = BannerController()
    try app.register(collection: bannersController)
    
    let categoriesController = CategoryController()
    try app.register(collection: categoriesController)

    
    try app.register(collection: TodoController())
}
