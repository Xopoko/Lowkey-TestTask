//
//  GalleryAssembly.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import UIKit

enum GalleryAssembly {
    
    // MARK: Internal methods
    static func assemble(with navigation: UINavigationController?) -> UIViewController {
        let interactor = GalleryInteractor()
        let router = GalleryRouter(navigation: navigation)
        let presenter = GalleryPresenter(
            router: router,
            interactor: interactor
        )
        
        let containerView = GalleryView()
        let controller = GalleryViewController(
            presenter: presenter,
            container: containerView
        )
        
        presenter.controller = controller
        router.controller = controller
        
        return controller
    }
}
