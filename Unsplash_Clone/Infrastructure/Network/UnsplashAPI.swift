//
//  UnsplashAPI.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/23.
//

import Foundation
import LWBNetwork
import UnsplashPhotoPicker

struct UnsplashAPI: API {
    typealias ResponseType = [UnsplashPhoto]
    
    var configuration: APIConfiguration?
    
    init() {
        configuration = APIConfiguration(
            method: .get,
            baseURL: "https://api.unsplash.com/",
            path: "photos",
            parameters: nil,
            headerField: ["Authorization": "Client-ID " + Bundle.main.accessKey]
        )
    }
}
