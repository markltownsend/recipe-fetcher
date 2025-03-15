//
//  RecipeApiKey.swift
//  Recipe Fetcher
//
//  Created by Mark Townsend on 3/12/25.
//

import Foundation
import Core
import Network

private struct RecipeApiKey: InjectedKey {
    nonisolated(unsafe) static var currentValue: any NetworkService = RecipeApi()
}

extension InjectedValues {
    public var recipeApi: any NetworkService {
        get { Self[RecipeApiKey.self] }
        nonmutating set { Self[RecipeApiKey.self] = newValue }
    }
}
