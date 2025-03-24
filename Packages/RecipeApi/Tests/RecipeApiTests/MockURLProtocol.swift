//
//  MockURLProtocol.swift
//  RecipeApi
//
//  Created by Mark Townsend on 3/23/25.
//

import Foundation
import Testing
import OSLog

// For Swift 6 compliance, this actor holds the current handler closure that `MockURLProtocol` uses to execute the
// mock network call
actor RequestHandlerStorage {
    private var requestHandler: ( @Sendable (URLRequest) async throws -> (HTTPURLResponse, Data))?

    func setHandler(_ handler: @escaping ( @Sendable (URLRequest) async throws -> (HTTPURLResponse, Data))) {
        self.requestHandler = handler
    }

    func executeHandler(for request: URLRequest) async throws -> (HTTPURLResponse, Data) {
        guard let handler = requestHandler else {
            throw MockURLProtocolError.noRequestHandler
        }
        return try await handler(request)
    }
}

// Since `URLProtocol` is an ObjC NSObject protocol, it is inherently not Swift Concurrency safe. Adding
// `@unchecked Sendable` tells the compiler that the developer is aware of this and to continue as if properly checked
final class MockURLProtocol: URLProtocol, @unchecked Sendable {
    static let requestHandlerStorage = RequestHandlerStorage()

    static func setHandler(_ handler: @Sendable @escaping (URLRequest) async throws -> (HTTPURLResponse, Data)) async {
        await requestHandlerStorage.setHandler { request in
            try await handler(request)
        }
    }

    func executeHandler(for request: URLRequest) async throws -> (HTTPURLResponse, Data) {
        try await Self.requestHandlerStorage.executeHandler(for: request)
    }

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        Task {
            do {
                let (response, data) = try await self.executeHandler(for: request)

                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
    }

    override func stopLoading() {
        
    }
}

enum MockURLProtocolError: Error {
    case noRequestHandler
    case invalidURL
}
