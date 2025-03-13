//
//  TestHelpers.swift
//  TestUtilities
//
//  Created by Mark Townsend on 3/13/25.
//

import Foundation

public enum TestHelpers {
    public static let recipesFileName = "recipes"
    public static let recipesEmptyFileName = "recipes-empty"
    public static let recipesMalformedFileName = "recipes-malformed"
    
    public static func createRemoteData<T: Decodable>(jsonData: String) throws -> T {
        let data = jsonData.data(using: .utf8)!
        return try JSONDecoder().decode(T.self, from: data)
    }


    public static func createRemoteData<T: Decodable>(fromFile fileName: String, in bundle: Bundle? = nil) throws -> T {
        let jsonString = loadJSONString(fromFile: fileName, in: bundle)
        return try createRemoteData(jsonData: jsonString)
    }

    public static func loadJSONString(fromFile fileName: String, in bundle: Bundle? = nil) -> String {
        let testBundle = bundle ?? Bundle.module
        guard let url = testBundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("Can't find file with name \(fileName)")
        }

        guard let data = try? Data(contentsOf: url),
              let jsonString = String(data: data, encoding: .utf8)
        else {
            fatalError("Can't convert data to string")
        }

        return jsonString
    }
}
