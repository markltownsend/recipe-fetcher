//
//  MockApiService.swift
//  RecipeApi
//
//  Created by Mark Townsend on 3/15/25.
//

import Foundation
import Model
import Network
import TestUtilities
import Core
import SwiftUI

// MARK - MockApiService for getting all recipes
public final class MockApiService: NetworkService {
    public init() {}
    
    public func fetchAll() async throws -> [Recipe] {
        let jsonString = TestHelpers.loadJSONString(fromFile: TestHelpers.recipesFileName)
        if let remoteData = jsonString.data(using: .utf8) {
            let recipeContainer: RecipeContainer = try decode(remoteData)
            return recipeContainer.recipes
        } else {
            throw NetworkError.badData
        }
    }
}
