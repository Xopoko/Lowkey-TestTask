//
//  CuratedResponse.swift
//  Lowkey-TestTask-MaxUI
//
//  Created by Maksim Kudriavtsev on 16/07/2023.
//

import Foundation

struct PexelsResponse: Decodable {
    let page: Int
    let perPage: Int
    let photos: [Photo]
    let nextPageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
        case nextPageUrl = "next_page"
    }
}
