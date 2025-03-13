
import Foundation

enum Endpoint {
    static let baseUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net")!
    static let recipes = baseUrl.appending(path: "recipes.json")
    static let empty_recipes = baseUrl.appending(path: "recipes-empty.json")
    static let malformed_recipes = baseUrl.appending(path: "recipes-malformed.json")
}
