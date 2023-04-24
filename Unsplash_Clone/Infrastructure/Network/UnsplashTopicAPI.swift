//
//  UnsplashTopicAPI.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/23.
//

import Foundation
import LWBNetwork
import UnsplashPhotoPicker

struct UnsplashTopicAPI: API {
    typealias ResponseType = [UnsplashPhoto]
    
    var configuration: APIConfiguration?
    
    init(topic: Topic) {
        configuration = APIConfiguration(
            method: .get,
            baseURL: "https://api.unsplash.com/",
            path: "topics/\(topic.slug)/photos",
            parameters: nil,
            headerField: ["Authorization": "Client-ID " + Bundle.main.accessKey]
        )
    }
}
