//
//  Injected.swift
//  Core
//
//  Created by Mark Townsend on 3/12/25.
//

import Foundation

@propertyWrapper @MainActor
public struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>

    public var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }

    public init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}
