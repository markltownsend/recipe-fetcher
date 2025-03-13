//
//  GlobalConstants.swift
//  Core
//
//  Created by Mark Townsend on 3/13/25.
//

import Foundation


public var isXcodeRunningForPreviews: Bool {
#if DEBUG
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
#else
    false
#endif
}
