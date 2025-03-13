//
//  InjectedKey.swift
//  Core
//
//  Created by Mark Townsend on 3/12/25.
//

import Foundation

public protocol InjectedKey {
    associatedtype Value

    static var currentValue: Self.Value { get set }
}

