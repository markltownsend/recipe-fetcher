//
//  RecipesScreen.swift
//  Recipe Fetcher
//
//  Created by Mark Townsend on 3/12/25.
//

import SwiftUI
import Model
import Core

struct RecipesScreen: View {
    @StateObject private var viewModel = RecipesViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    List {
                        ForEach(Recipe.preview) { recipe in
                            RecipeRowView(recipe: recipe)
                        }
                        .redacted(reason: viewModel.isLoading ? .placeholder : [])
                    }
                } else if viewModel.recipes.isEmpty {
                    ContentUnavailableView()
                } else {
                    List(Array(viewModel.cuisines), id: \.self) { cuisine in
                        Section {
                            ForEach(viewModel.recipes(forCuisine: cuisine)) { recipe in
                                RecipeRowView(recipe: recipe)
                            }
                        } header: {
                            Text(cuisine)
                        }
                    }
                    .refreshable {
                        await viewModel.fetchRecipes()
                    }
                }
            }
            .listSectionSeparator(.hidden)
            .listStyle(.plain)
            .navigationTitle(Text("Recipes"))
            .task {
                await viewModel.fetchRecipes()
            }
            .alert("Error", isPresented: $viewModel.isShowingErrorAlert) {
                // Only need an OK button here, so just an empty action is needed
            } message: {
                Text(viewModel.errorMessage())
            }
        }

    }
}

@available(iOS 18, *)
#Preview("Success", traits: .mockApiServicePreview) {
    RecipesScreen()
}

@available(iOS 18, *)
#Preview("Empty", traits: .mockEmptyApiServicePreview) {
    RecipesScreen()
}

@available(iOS 18, *)
#Preview("Malformed", traits: .mockMalformedApiServicePreview) {
    RecipesScreen()
}
