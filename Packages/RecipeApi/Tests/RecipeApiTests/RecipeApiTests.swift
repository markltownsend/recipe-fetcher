import Testing
import Network
import TestUtilities
import Foundation
@testable import RecipeApi

// Tests are run as `serialized` because of the use of the ObjC subclass `MockURLProtocol` which is
// not considered Swift 6 concurrency safe. Since it's for testing purposes only, it is set as `@unchecked Sendable`
// In order to ensure no data races with setting the handler, running the tests this way ensures this.

@Suite("RecipeAPITests", .serialized)
final class RecipeApiTests {
    let session: URLSession
    let apiService: any NetworkService

    init() {
        session = {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [MockURLProtocol.self]
            return URLSession(configuration: configuration)
        }()
        apiService = RecipeApi(session: session)
    }

    @Test
    func fetchAll() async throws {
        let mockData = TestHelpers.loadJSONData(fromFile: TestHelpers.recipesFileName)
        await MockURLProtocol.setHandler { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, mockData)
        }
        let recipes = try await apiService.fetchAll()
        #expect(!recipes.isEmpty)
    }

    @Test
    func testEmpty() async throws {
        let mockData = TestHelpers.loadJSONData(fromFile: TestHelpers.recipesEmptyFileName)
        await MockURLProtocol.setHandler { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, mockData)
        }
        
        let recipes = try await apiService.fetchAll()
        #expect(recipes.isEmpty)
    }

    @Test
    func testMalformed() async throws {
        let mockData = TestHelpers.loadJSONData(fromFile: TestHelpers.recipesMalformedFileName)
        await MockURLProtocol.setHandler { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, mockData)
        }
        await #expect(throws: DecodingError.self) {
            _ = try await apiService.fetchAll()
        }
    }
}
