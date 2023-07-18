//
//  DetailRouter.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import UIKit

protocol DetailRouterProtocol {
    func openUrl(_ url: URL)
}

final class DetailRouter: DetailRouterProtocol {
    
    // MARK: Public properties
    weak var controller: UIViewController?
    
    // MARK: Private properties
    private weak var navigation: UINavigationController?
    
    // MARK: Init
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func openUrl(_ url: URL) {
        UIApplication.shared.open(url)
    }
}
