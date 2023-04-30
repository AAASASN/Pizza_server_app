import Fluent
import Vapor

final class Todo: Model, Content {
    static let schema = "todos"
    
    @ID()
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "someInt")
    var someInt: Int
    

    init() { }

    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
        self.someInt = someInt
    }
}
