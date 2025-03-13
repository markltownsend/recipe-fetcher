
import Foundation
import Network
import Model

public struct RecipeApi: NetworkService {
    public init() {}
    
    public func fetchAll() async throws -> [Recipe] {
        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: Endpoint.recipes)
        let (data, response) = try await urlSession.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }

        switch httpResponse.statusCode {
        case 200:
            return try JSONDecoder().decode(RecipeContainer.self, from: data).recipes
        case 404:
            throw NetworkError.notFound
        default:
            throw NetworkError.unknown
        }
    }
}
