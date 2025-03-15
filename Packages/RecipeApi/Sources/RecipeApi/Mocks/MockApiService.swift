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
final class MockApiService: NetworkService {
    func fetchAll() async throws -> [Recipe] {
        let remoteData: RecipeContainer = try TestHelpers.createRemoteData(fromFile: TestHelpers.recipesFileName)
        return remoteData.recipes
    }
}
