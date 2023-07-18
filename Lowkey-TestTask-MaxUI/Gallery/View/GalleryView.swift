//
//  GalleryView.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import UIKit
import MaxUI
import Combine

extension GalleryView {
    struct Model {
        @MState
        var photos: [Photo]
        var didSelectPhoto: (Photo) -> Void
        var loadMore: () -> Void
        var refreshHandler: () -> Void
    }
}

final class GalleryView: UIView {
    private var refreshHandler: (() -> Void)?
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        control.backgroundColor = .mainBackgroundColor

        return control
    }()
    
    func configure(with model: Model) {
        MCollection(
            model.$photos.map { photos in
                photos.map { photo in
                    MZStack {
                        MImage(.constant(RemoteImage(url: URL(string: photo.src.landscape)!)))
                            .contentMode(.scaleAspectFill)
                            .cornerRadius(12)
                            .toContainer()
                            .shadow(offsetX: 0, offsetY: 4, color: .mainShadowColor, opacity: 0.4, radius: 4)
                        MText(photo.photographer)
                            .font(.systemFont(ofSize: 18, weight: .semibold))
                            .textColor(.white)
                            .textAlignment(.center)
                            .insets(left: 16, bottom: 8)
                    }
                    .height(200)
                    .insets(left: 16, right: 16, bottom: 16)
                    .onSelect { model.didSelectPhoto(photo) }
                }
            }
        )
        .refreshControl(refreshControl)
        .trackDataConsumed(treshold: 2) { model.loadMore() }
        .configure(in: self)
        
        refreshHandler = model.refreshHandler
        
        model.$photos.publisher.sink { [weak self] _ in
            if self?.refreshControl.isRefreshing == true {
                self?.refreshControl.endRefreshing()
            }
        }
        .store(in: &cancellables)
        
    }
    
    @objc
    private func refresh() {
        refreshHandler?()
    }
}

#if DEBUG
import SwiftUI
struct Gallery_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(previewDevices, id: \.self) {
            UIViewPreview {
                let view = GalleryView()
                view.configure(
                    with: GalleryView.Model(
                        photos: Array(repeating: mockPhoto, count: 20),
                        didSelectPhoto: { print($0) },
                        loadMore: {},
                        refreshHandler: {}
                    )
                )
                return view
            }
            .ignoresSafeArea()
            .previewDevice($0)
        }
    }
}
#endif
