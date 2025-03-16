//
//  SafariControllerView.swift
//  Core
//
//  Created by Mark Townsend on 3/15/25.
//

import SwiftUI
import SafariServices

public struct SafariControllerView: UIViewControllerRepresentable {

    private var url: URL

    public init(url: URL) {
        self.url = url
    }
    
    public func makeUIViewController(context: Context) -> SFSafariViewController {
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = true
        let viewController = SFSafariViewController(url: url, configuration: configuration)
        viewController.preferredBarTintColor = .tintColor
        viewController.preferredControlTintColor = UIColor(named: "ControlTintColor")!
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Nothing to do here
    }
}
