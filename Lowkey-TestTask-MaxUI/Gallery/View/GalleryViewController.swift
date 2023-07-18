//
//  GalleryViewController.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import UIKit

protocol GalleryViewControllerProtocol: AnyObject {
    func updateData(with model: GalleryView.Model)
}

final class GalleryViewController: UIViewController, GalleryViewControllerProtocol {
    
    // MARK: Private properties
    private let presenter: GalleryPresenterProtocol
    private let moduleView: GalleryView
    
    // MARK: Init
    init(presenter: GalleryPresenterProtocol, container: GalleryView) {
        self.presenter = presenter
        self.moduleView = container
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrided methods
    override func loadView() {
        view = moduleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        presenter.didLoadView()
    }
    
    // MARK: GalleryViewProtocol
    func updateData(with model: GalleryView.Model) {
        moduleView.configure(with: model)
    }
}

// MARK: - Private methods
extension GalleryViewController {
    private func setupLayout() {
        title = "Curated"
        view.backgroundColor = .mainBackgroundColor
    }
}
