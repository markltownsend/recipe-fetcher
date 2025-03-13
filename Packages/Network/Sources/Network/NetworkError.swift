//
//  NetworkError.swift
//  Network
//
//  Created by Mark Townsend on 3/11/25.
//

import Foundation

public enum NetworkError: Error {
    case badResponse
    case badData
    case notFound
    case unknown
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badResponse:
            String(localized: "The response was unexpected")
        case .badData:
            String(localized: "The data returned was unexpected")
        case .notFound:
            String(localized: "The data was not found")
        case .unknown:
            String(localized: "An unknown error occurred")
        }
    }

}
