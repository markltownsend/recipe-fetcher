//
//  FetchImage.swift
//  Core
//
//  Created by Mark Townsend on 3/14/25.
//

import Foundation
import SwiftUI

public struct FetchImage: View {
    let url: URL?

    @State private var image: Image?

    public init(url: URL?) {
        self.url = url
    }

    public var body: some View {
        VStack {
            if let image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Rectangle().fill(Color.gray)
            }
        }
        .animation(.default, value: image)
        .task {
            if let url,
               let uiImage = try? await ImageLoader.shared.loadImage(url: url) {
                image = Image(uiImage: uiImage)
            }
        }
    }
}
