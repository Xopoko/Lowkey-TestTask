//
//  RemoteImage.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import UIKit
import MaxUI

final class RemoteImage {
    let url: URL?
    
    init(url: URL? = nil) {
        self.url = url
    }
    
    func image(
        from url: URL,
        applyTo appliable: UIImageView
    ) {
        let configuration = URLSessionConfiguration.default
        let cache = URLCache(
            memoryCapacity: 50 * (1024 * 1024),
            diskCapacity: 200 * (1024 * 1024),
            diskPath: "images"
        )
        configuration.urlCache = cache
        
        let urlSession = URLSession(configuration: configuration)
        urlSession.dataTask(with: url) { [weak appliable] data, _, error in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                guard let data else { return }
                
                appliable?.image = UIImage(data: data)
                appliable?.sizeToFit()
            }
        }.resume()
    }
}

extension RemoteImage: ImageSettable {
    func setImage(for imageView: UIImageView) {
        if let url {
            image(from: url, applyTo: imageView)
        }
    }
}
