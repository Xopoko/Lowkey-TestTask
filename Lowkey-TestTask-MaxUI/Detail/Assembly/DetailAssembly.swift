//
//  DetailAssembly.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import UIKit
enum DetailAssembly {
    
    // MARK: Internal methods
    static func assemble(with navigation: UINavigationController?, photo: Photo) -> UIViewController {
        let router = DetailRouter(navigation: navigation)
        let presenter = DetailPresenter(
            router: router,
            photo: photo
        )
        
        let containerView = DetailView()
        let controller = DetailViewController(
            presenter: presenter,
            container: containerView
        )
        
        controller.navigationItem.largeTitleDisplayMode = .never
        
        presenter.controller = controller
        router.controller = controller
        
        return controller
    }
}
