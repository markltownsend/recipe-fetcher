//
//  RecipesViewModel.swift
//  Recipe Fetcher
//
//  Created by Mark Townsend on 3/12/25.
//

import Foundation
import Model
import RecipeApi
import Core
import Network

@MainActor
final class RecipesViewModel: ObservableObject {

    @Injected(\.recipeApi) var recipeApi: any NetworkService

    @Published var recipes: [Recipe] = []
    @Published var currentError: (any Error)? = nil
    @Published var isShowingErrorAlert: Bool = false
    @Published var isLoading: Bool = false
    @Published var cuisines: [String] = []

    private var recipesByCuisine: [String: [Recipe]] = [:]

    func fetchRecipes() async {
        defer {
            isLoading = false
        }

        do {
            isLoading = true
            let fetchedRecipes: [Recipe] = try await recipeApi.fetchAll() as? [Recipe] ?? []
            recipes = fetchedRecipes
            createCuisinesMapping()
        } catch {
            currentError = error
            isShowingErrorAlert = true
        }
    }

    func recipes(forCuisine cuisine: String) -> [Recipe] {
        recipesByCuisine[cuisine] ?? []
    }

    func errorMessage() -> String {
        if let currentError {
            currentError.localizedDescription
        } else {
            String(localized: "Something happened. Please try again later.")
        }
    }
    
    private func createCuisinesMapping() {
        let cuisines = Set(recipes.map(\.cuisine))
        let cuisinesMapping = cuisines
            .reduce(into: [String: [Recipe]]()) { result, cuisine in
                let recipesForCuisine = recipes.filter { $0.cuisine == cuisine }
                result[cuisine] = recipesForCuisine
            }
        self.cuisines = Array(cuisines).sorted()
        recipesByCuisine = cuisinesMapping
    }

}
