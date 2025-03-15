//
//  MockEmptyApiServicePreviewProvider.swift
//  RecipeApi
//
//  Created by Mark Townsend on 3/15/25.
//

import SwiftUI
import Core

struct MockEmptyApiServicePreviewProvider: PreviewModifier {
    static func makeSharedContext() async throws -> MockEmptyApiService {
        let service = MockEmptyApiService()
        InjectedValues[\.recipeApi] = service
        return service
    }

    func body(content: Content, context: MockEmptyApiService) -> some View {
        content
    }
}

@available(iOS 18, *)
public extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var mockEmptyApiServicePreview: Self = .modifier(MockEmptyApiServicePreviewProvider())
}
