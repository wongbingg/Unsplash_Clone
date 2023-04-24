//
//  Bundle+.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/20.
//

import Foundation

extension Bundle {
    var accessKey: String {
        guard let file = self.path(forResource: "API_Info", ofType: "plist") else {
            return ""
        }
        guard let resource = NSDictionary(contentsOfFile: file) else {
            return ""
        }
        guard let key = resource["AccessKey"] as? String else {
            fatalError("API_Info에 AccessKey 값을 입력 해주세요.")
        }
        return key
    }
    
    var secretKey: String {
        guard let file = self.path(forResource: "API_Info", ofType: "plist") else {
            return ""
        }
        guard let resource = NSDictionary(contentsOfFile: file) else {
            return ""
        }
        guard let key = resource["Secret_KEY"] as? String else {
            fatalError("API_Info에 Secret_KEY 값을 입력 해주세요.")
        }
        return key
    }
}
