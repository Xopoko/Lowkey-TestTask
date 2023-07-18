//
//  DetailView.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import UIKit
import MaxUI

extension DetailView {
    struct Model {
        let photo: Photo
        let didTapOnNickname: () -> Void
    }
}

final class DetailView: UIView {
    private let remoteImage = RemoteImage()
    
    func configure(with model: Model) {
        // ChatGTP generated ImageViewer
        let imageViewer = ImageViewer()
        // Quick load of large "preview"
        remoteImage.image(from: URL(string: model.photo.src.large)!, applyTo: imageViewer.imageView)
        // Load original
        remoteImage.image(from: URL(string: model.photo.src.original)!, applyTo: imageViewer.imageView)
        
        // A little hack that fix the size and corners on ImageViewer
        let screenWidth = UIScreen.main.bounds.width - 32 // This is screen width minus horizontal insets of the imageViewer
        let originalImageWidth = max(CGFloat(model.photo.width), screenWidth)
        let originalImageHeight = CGFloat(model.photo.height)
        let aspectRatio = originalImageWidth / originalImageHeight
        let calculatedHeight = screenWidth / aspectRatio
        
        MVStack {
            // Photographer name
            MText(model.photo.photographer)
                .textColor(.mainTextColor)
                .font(.systemFont(ofSize: 24, weight: .semibold))
                .insets(horizontal: 16)
            MSpacer(height: 6)
            // Photographer nickname
            MButton("@\(model.photo.authorNickname)") {
                model.didTapOnNickname()
            }
            .textColor(.mainLinkColor)
            .textAlignment(.left)
            .font(.systemFont(ofSize: 18, weight: .medium))
            .insets(horizontal: 16)
            
            MSpacer(height: 20)
            
            MHStack {
                MSpacer()
                // Photo with zoom
                imageViewer
                    .asComponent()
                    .height(calculatedHeight)
                    .priority(.shrinkVertical)
                MSpacer()
            }
            .toContainer()
            .shadow(offsetX: 0, offsetY: 4, color: .mainShadowColor, opacity: 0.4, radius: 4)
            .insets(horizontal: 16)
            MSpacer()
        }
        .configure(in: self, safeArea: true)
    }
}

#if DEBUG
import SwiftUI
struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(previewDevices, id: \.self) { device in
            NavigationStack {
                UIViewPreview {
                    let view = DetailView()
                    view.configure(with: DetailView.Model(photo: mockPhoto, didTapOnNickname: {}))
                    return view
                }
                .previewDevice(device)
            }
        }
    }
}
#endif
