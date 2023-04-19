//
//  HomeViewModel.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/15.
//

import UnsplashPhotoPicker

protocol HomeViewModelInput {
    func viewDidLoad()
}

protocol HomeViewModelOutput {
    var photos: [UnsplashPhoto] { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}

final class DefaultHomeViewModel: HomeViewModel {
    private(set) var photos: [UnsplashPhoto] = []
    
    init() {}
    
    func viewDidLoad() {
        // photos 에 데이터 채워주기 UseCase
    }
}
