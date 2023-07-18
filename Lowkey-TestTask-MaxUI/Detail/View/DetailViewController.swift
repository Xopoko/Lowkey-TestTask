//
//  DetailViewController.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import UIKit
import MaxUI

protocol DetailViewControllerProtocol: AnyObject {
    func updateData(with model: DetailView.Model)
}

final class DetailViewController: UIViewController, DetailViewControllerProtocol {
    
    // MARK: Private properties
    private let presenter: DetailPresenterProtocol
    private let moduleView: DetailView
    
    // MARK: Init
    init(presenter: DetailPresenterProtocol, container: DetailView) {
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
    
    // MARK: DetailViewProtocol
    func updateData(with model: DetailView.Model) {
        moduleView.configure(with: model)
    }
}

// MARK: - Private methods
extension DetailViewController {
    private func setupLayout() {
        view.backgroundColor = .mainBackgroundColor
    }
}
