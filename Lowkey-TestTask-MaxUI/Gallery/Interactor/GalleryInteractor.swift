//
//  GalleryInteractor.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import Foundation

protocol GalleryInteractorProtocol: AnyObject {
    var initialURL: URL { get }
    func loadList(by url: URL, completion: @escaping (PexelsResponse) -> Void)
}

final class GalleryInteractor: GalleryInteractorProtocol {
    let initialURL = URL(string: "https://api.pexels.com/v1/curated?page=1&per_page=20")!
    
    // MARK: GalleryInteractorProtocol
    func loadList(by url: URL, completion: @escaping (PexelsResponse) -> Void) {
        var request = URLRequest(url: url)
        request.addValue(
            "38YDirZfBLvwZ5jxN8RV401MtKbqEtb6s9hMQUAr8nds0xC5bQY6st2h",
            forHTTPHeaderField: "Authorization"
        )
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(PexelsResponse.self, from: data!)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

// MARK: - Private methods
extension GalleryInteractor {
}
