//
//  API+.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/23.
//

import Foundation
import LWBNetwork
import RxSwift

extension API {
    func execute() -> Single<ResponseType> {
        
        guard let urlRequest = try? configuration?.makeURLRequest() else {
            let error = APIError.error("APIError: 유효하지 않은 URL 입니다.")
            return .error(error)
        }
        return Single<ResponseType>.create { single in
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                guard let data = data,
                      let result = try? JSONDecoder().decode(ResponseType.self, from: data) else {
                    single(.failure(APIError.error("APIError: decode 에러")))
                    return
                }
                single(.success(result))
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
