//
//  Navigator.swift
//  CurrencyConverter
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit

protocol Navigator {
    func push(_ dest: Destination)
}

/// once app navigator is intialized,
///  it have a root controller to do all navigation on till it recieve new root
final class AppNavigator: Navigator {
    private static var rootController: UINavigationController!
    @discardableResult
    init(window: UIWindow) {
        AppNavigator.rootController = UINavigationController(rootViewController: Destination.currencySelector.controller())
        window.rootViewController = AppNavigator.rootController
        window.makeKeyAndVisible()
    }

    init() throws {
        if AppNavigator.rootController == nil {
            throw NavigatorError.noRoot
        }
    }

    func back() {
        AppNavigator.rootController.popViewController(animated: true)
    }

    func push(_ dest: Destination) {
        AppNavigator.rootController.pushViewController(dest.controller(), animated: true)
    }
}

enum NavigatorError: Error {
    case noRoot
}
