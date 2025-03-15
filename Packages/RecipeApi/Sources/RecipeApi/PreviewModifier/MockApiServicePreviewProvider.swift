//
//  MockApiServicePreviewProvider.swift
//  RecipeApi
//
//  Created by Mark Townsend on 3/15/25.
//

import SwiftUI
import Core

struct MockApiServicePreviewProvider: PreviewModifier {
    static func makeSharedContext() async throws -> MockApiService {
        let service = MockApiService()
        InjectedValues[\.recipeApi] = service
        return service
    }

    func body(content: Content, context: MockApiService) -> some View {
        content
    }
}

@available(iOS 18, *)
public extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var mockApiServicePreview: Self = .modifier(MockApiServicePreviewProvider())
}
