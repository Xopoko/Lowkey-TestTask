//
//  GalleryPresenter.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import Foundation

protocol GalleryPresenterProtocol: AnyObject {
    func didLoadView()
}

final class GalleryPresenter: GalleryPresenterProtocol {
    
    // MARK: Public properties
    weak var controller: GalleryViewControllerProtocol?
    
    // MARK: Private properties
    private let router: GalleryRouterProtocol
    private let interactor: GalleryInteractorProtocol
    
    private var nextPageUrl: URL?
    private var isLoading = false
    
    private lazy var model = GalleryView.Model(photos: []) { [weak self] photo in
        self?.handleDidSelectPhoto(photo)
    } loadMore: { [weak self] in
        self?.handleLoadMore()
    } refreshHandler: { [weak self] in
        self?.handleRefresh()
    }
    
    // MARK: Init
    init(
        router: GalleryRouterProtocol,
        interactor: GalleryInteractorProtocol
    ) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: GalleryPresenterProtocol
    func didLoadView() {
        controller?.updateData(with: model)
        
        loadPage(initial: true)
    }
}

// MARK: - Private methods
extension GalleryPresenter {
    private func loadPage(initial: Bool) {
        guard !isLoading else {
            print("Is something already in loading")
            return
        }
        let url = initial ? interactor.initialURL : nextPageUrl
        guard let url else {
            print("The nextPageUrl is nil or this is the last page")
            return
        }
        isLoading = true
        interactor.loadList(by: url) { [weak self] pexelResponse in
            if initial {
                self?.model.photos = pexelResponse.photos
            } else {
                self?.model.photos.append(contentsOf: pexelResponse.photos)
            }
            self?.nextPageUrl = URL(string: pexelResponse.nextPageUrl)
            self?.isLoading = false
        }
    }
    
    private func handleDidSelectPhoto(_ photo: Photo) {
        router.openDetail(photo)
    }
    
    private func handleLoadMore() {
        loadPage(initial: false)
    }
    
    private func handleRefresh() {
        loadPage(initial: true)
    }
}
