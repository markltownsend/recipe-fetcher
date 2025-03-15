//
//  MockMalformedApiServicePreviewProvider.swift
//  RecipeApi
//
//  Created by Mark Townsend on 3/15/25.
//

import SwiftUI
import Core

struct MockMalformedApiServicePreviewProvider: PreviewModifier {
    static func makeSharedContext() async throws -> MockMalformedApiService {
        let service = MockMalformedApiService()
        InjectedValues[\.recipeApi] = service
        return service
    }

    func body(content: Content, context: MockMalformedApiService) -> some View {
        content
    }
}

@available(iOS 18, *)
public extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var mockMalformedApiServicePreview: Self = .modifier(MockMalformedApiServicePreviewProvider())
}
