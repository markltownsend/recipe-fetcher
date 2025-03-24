
import Foundation
import Network
import Model

public struct RecipeApi: NetworkService {
    public let session: URLSession
    public let decoder: JSONDecoder

    public init(session: URLSession = URLSession.shared,
                decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    public func fetchAll() async throws -> [Recipe] {
        let urlRequest = URLRequest(url: Endpoint.recipes)
        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }

        switch httpResponse.statusCode {
        case 200:
            let recipeContainer: RecipeContainer = try decode(data)
            return recipeContainer.recipes
        case 404:
            throw NetworkError.notFound
        default:
            throw NetworkError.unknown
        }
    }
}
