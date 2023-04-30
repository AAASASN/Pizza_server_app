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

    let mealsController = MealController()
    try app.register(collection: mealsController)
    
    let bannersController = BannerController()
    try app.register(collection: bannersController)
    
    let categoriesController = CategoryController()
    try app.register(collection: categoriesController)

}
