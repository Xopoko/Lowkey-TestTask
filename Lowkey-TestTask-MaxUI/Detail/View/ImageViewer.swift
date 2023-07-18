//
//  ImageViewer.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import UIKit
import MaxUI

class ImageViewer: UIView, UIGestureRecognizerDelegate {
    var initialFrame: CGRect?
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor).isActive = true
        
        setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestureRecognizers() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        pinchGesture.delegate = self
        imageView.addGestureRecognizer(pinchGesture)
    }
    
    @objc private func handlePinch(gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            let locationInView = gesture.location(in: imageView)
            let locationInSuperview = gesture.location(in: imageView.superview)
            imageView.layer.anchorPoint = CGPoint(x: locationInView.x / imageView.bounds.width, y: locationInView.y / imageView.bounds.height)
            imageView.center = locationInSuperview
            initialFrame = imageView.frame
            imageView.translatesAutoresizingMaskIntoConstraints = true  // Temporarily disable auto-layout
        case .changed:
            guard gesture.scale >= 1 || imageView.transform.a > 1 else {
                return
            }
            let scale = gesture.scale
            imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        case .ended, .cancelled:
            UIView.animate(withDuration: 0.3, animations: {
                self.imageView.transform = CGAffineTransform.identity
            }, completion: { _ in
                self.imageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                if let initialFrame = self.initialFrame {
                    self.imageView.frame = initialFrame
                }
                self.imageView.translatesAutoresizingMaskIntoConstraints = false  // Re-enable auto-layout
            })
        default:
            break
        }
    }
}

#if DEBUG
import SwiftUI
struct ImageViewer_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(previewDevices, id: \.self) { device in
            NavigationStack {
                UIViewPreview {
                    let imageViewer = ImageViewer()
                    imageViewer.imageView.image = UIImage(named: "mockImage")
                    return imageViewer
                }
                .previewDevice(device)
            }
        }
    }
}
#endif
