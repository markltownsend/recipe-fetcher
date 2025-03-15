import Testing
import Network
@testable import RecipeApi

@Suite("RecipeAPITests")
struct RecipeApiTests {

    @Test
    func fetchAll() async throws {
        let apiService: any NetworkService = MockApiService()
        let recipes = try await apiService.fetchAll()
        #expect(!recipes.isEmpty)
    }

    @Test
    func testEmpty() async throws {
        let apiService: any NetworkService = MockEmptyApiService()
        let recipes = try await apiService.fetchAll()
        #expect(recipes.isEmpty)
    }

    @Test
    func testMalformed() async throws {
        let apiService: any NetworkService = MockMalformedApiService()
        await #expect(throws: DecodingError.self) {
            _ = try await apiService.fetchAll()
        }

    }
}
