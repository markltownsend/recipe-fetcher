//
//  Recipe_FetcherTests.swift
//  Recipe FetcherTests
//
//  Created by Mark Townsend on 3/12/25.
//

import Core
import Testing
import RecipeApi
@testable import Recipe_Fetcher

@MainActor
struct Recipe_FetcherTests {

    @Test func testFetchRecipes() async throws {
        InjectedValues[\.recipeApi] = MockApiService()
        let viewModel = RecipesViewModel()
        await viewModel.fetchRecipes()

        #expect(viewModel.recipes.count > 0)
        #expect(viewModel.cuisines.count > 0)
        #expect(viewModel.isLoading == false)
    }

    @Test func testFetchRecipesWithError() async throws {
        InjectedValues[\.recipeApi] = MockMalformedApiService()
        let viewModel = RecipesViewModel()
        await viewModel.fetchRecipes()
        
        #expect(viewModel.recipes.isEmpty)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.currentError != nil)
        #expect(viewModel.isShowingErrorAlert == true)
    }

}
