//
//  MockMalformedApiService.swift
//  RecipeApi
//
//  Created by Mark Townsend on 3/15/25.
//

import Network
import Model
import TestUtilities

// MARK: - MockApiService for malformed service
final class MockMalformedApiService: NetworkService {
    func fetchAll() async throws -> [Recipe] {
        let remoteData: RecipeContainer = try TestHelpers.createRemoteData(
            fromFile: TestHelpers.recipesMalformedFileName
        )
        return remoteData.recipes
    }
}
