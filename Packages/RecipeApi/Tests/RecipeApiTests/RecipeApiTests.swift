import Testing
import Network
@testable import RecipeApi

@Suite("RecipeAPITests")
struct RecipeApiTests {
    let apiService: any NetworkService = RecipeApi()

    @Test
    func fetchAll() async throws {
        let recipes = try await apiService.fetchAll()
        #expect(!recipes.isEmpty)
    }
}
