//
//  GalleryRouter.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import UIKit

protocol GalleryRouterProtocol {
    func openDetail(_ photo: Photo)
}

final class GalleryRouter: GalleryRouterProtocol {
    
    // MARK: Public properties
    weak var controller: UIViewController?
    
    // MARK: Private properties
    private weak var navigation: UINavigationController?
    
    // MARK: Init
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func openDetail(_ photo: Photo) {
        let detailModule = DetailAssembly.assemble(with: navigation, photo: photo)
        navigation?.pushViewController(detailModule, animated: true)
    }
}
