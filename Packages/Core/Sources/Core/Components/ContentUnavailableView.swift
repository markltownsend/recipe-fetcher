//
//  ContentUnavailableView.swift
//  Core
//
//  Created by Mark Townsend on 3/15/25.
//

import SwiftUI

public struct ContentUnavailableView: View {
    public init() {}
    public var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .symbolRenderingMode(.multicolor)
                .font(.largeTitle)
            Text("Uh oh!")
                .font(.title).bold()
            Text("Nothing to see here!")
                .font(.title2)
        }
    }
}

#Preview {
    ContentUnavailableView()
}
