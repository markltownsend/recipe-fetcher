//
//  InjectedValues.swift
//  Core
//
//  Created by Mark Townsend on 3/12/25.
//
//  Idea comes from SwiftLee: https://www.avanderlee.com/swift/dependency-injection/

import Foundation

@MainActor
public struct InjectedValues {
    private static var current = InjectedValues()

    public static subscript<K>(key: K.Type) -> K.Value where K: InjectedKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    public static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}
