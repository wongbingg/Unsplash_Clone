//
//  APIError.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/19.
//

import Foundation
import RxSwift
import UnsplashPhotoPicker

enum APIError: LocalizedError {
    case error(String)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case let .error(msg):
            return msg
        case .unknownError:
            return "알 수 없는 에러가 발생했습니다."
        }
    }
}
