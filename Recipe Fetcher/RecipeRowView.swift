//
//  RecipeRowView.swift
//  Recipe Fetcher
//
//  Created by Mark Townsend on 3/12/25.
//

import SwiftUI
import Model
import Core
struct RecipeRowView: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            FetchImage(url: URL(string: recipe.photoUrlSmall))
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 5.0))

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.caption).fontWeight(.semibold)

                showButtons()
                    .padding(.top, 20)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    @ViewBuilder
    func showButtons() -> some View {
        HStack {
            if let sourceUrl = recipe.sourceUrl, let url = URL(string: sourceUrl) {
                Button {

                } label: {
                    Label {
                        Text("Open Recipe")
                    } icon: {
                        Image(systemName: "frying.pan")
                            .font(.headline)

                    }
                    .labelStyle(.iconOnly)
                }
                .buttonStyle(.bordered)
            }

            if let youTubeUrl = recipe.youTubeUrl, let url = URL(string: youTubeUrl) {
                Button {

                } label: {
                    Label {
                        Text("Watch Video")
                    } icon: {
                        Image(systemName: "play.tv")
                            .font(.headline)
                    }
                    .labelStyle(.iconOnly)
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    RecipeRowView(recipe: Recipe.preview.first!)
}
