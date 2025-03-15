//
//  ImageLoader.swift
//  Core
//
//  Created by Mark Townsend on 3/14/25.
//

import Foundation
import SwiftUI
import os

public actor ImageLoader {
    public static let shared = ImageLoader()

    private var cache: UserDefaults?
    private let lastPurgedDateKey = "lastPurgedDate"
    private let expireIn: TimeInterval = 86_400 // 24 hours
    private static let cacheSuiteName = "ImageCache"
    private let logger = Logger(subsystem: "Core.ImageLoader", category: "Utility")

    init(_ cache: UserDefaults? = UserDefaults(suiteName: cacheSuiteName)) {
        self.cache = cache
    }

    @MainActor
    public func loadImage(url: URL) async throws -> UIImage? {
        // Check if the cache needs purging
        await purgeIfNeeded()

        // Is the url in the cache?
        if let image = await loadCacheImage(url: url) {
            return image
        }

        // Nope, load from network, put it in the cache
        do {
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            let session = URLSession(configuration: config)
            let (data, _) = try await session.data(from: url)
            if let uiImage = UIImage(data: data) {
                await addDataToCache(data, forKey: url.absoluteString)
                return uiImage
            } else {
                return nil
            }
        } catch {
            logger.log("Error downloading \(error)")
            throw error
        }
    }
    
    func loadCacheImage(url: URL) -> UIImage? {
        guard let data = cache?.object(forKey: url.absoluteString) as? Data
        else {
            return nil
        }
        return UIImage(data: data)
    }

    private func addDataToCache(_ data: Data, forKey key: String) async {
        cache?.set(data, forKey: key)
    }

    @discardableResult
    private func purgeIfNeeded() -> Bool {
        if let lastPurgeDate = cache?.object(forKey: lastPurgedDateKey) as? Date {
            if Date.now.timeIntervalSince(lastPurgeDate) > expireIn {
                cache?.removePersistentDomain(forName: Self.cacheSuiteName)
                return true
            }
        }
        cache?.set(Date.now, forKey: lastPurgedDateKey)
        return false
    }
}
