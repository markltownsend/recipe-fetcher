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
public final class MockMalformedApiService: NetworkService {
    public init() {}
    public func fetchAll() async throws -> [Recipe] {
        let jsonString = TestHelpers.loadJSONString(fromFile: TestHelpers.recipesMalformedFileName)
        if let remoteData = jsonString.data(using: .utf8) {
            let recipeContainer: RecipeContainer = try decode(remoteData)
            return recipeContainer.recipes
        } else {
            throw NetworkError.badData
        }
    }
}
