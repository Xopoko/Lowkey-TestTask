//
//  DetailPresenter.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func didLoadView()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    // MARK: Public properties
    weak var controller: DetailViewControllerProtocol?
    
    // MARK: Private properties
    private let router: DetailRouterProtocol
    private let photo: Photo
    
    // MARK: Init
    init(
        router: DetailRouterProtocol,
        photo: Photo
    ) {
        self.router = router
        self.photo = photo
    }
    
    // MARK: DetailPresenterProtocol
    func didLoadView() {
        let model = DetailView.Model(photo: photo, didTapOnNickname: { [weak self] in
            guard let self else { return }
            guard let photographerUrl = URL(string: self.photo.photographerUrl) else { return }
            
            self.router.openUrl(photographerUrl)
        })
        controller?.updateData(with: model)
    }
}

// MARK: - Private methods
extension DetailPresenter {
    
}
