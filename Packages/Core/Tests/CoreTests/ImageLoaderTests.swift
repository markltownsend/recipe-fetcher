//
//  ImageLoaderTests.swift
//  Core
//
//  Created by Mark Townsend on 3/14/25.
//

import Foundation
import Testing
@testable import Core

struct ImageLoaderTests {
    let imageLoader: ImageLoader

    init () async throws {
        imageLoader = ImageLoader(UserDefaults(suiteName: "ImageCacheTests"))
    }

    @Test("Load Image", arguments: [
        URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")!,
        URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg")!,
        URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")!
    ])
    func loadImage(_ url: URL) async throws {
        let uiImage = try #require(try await imageLoader.loadImage(url: url))
        let uiImageData = try #require(uiImage.pngData())

        let cachedImage = try #require(await imageLoader.loadCacheImage(url: url))

        let cacheImageData = try #require(cachedImage.pngData())

        #expect(uiImageData == cacheImageData)
    }

    @Test("Not Images", arguments: [
        URL(string: "https://www.apple.com")!,
        URL(string: "https://www.wikipedia.com")!
    ])
    func checkNotImage(_ url: URL) async throws {
        #expect(try await imageLoader.loadImage(url: url) == nil)
    }
}
