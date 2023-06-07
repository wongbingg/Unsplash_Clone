//
//  HomeViewModel.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/15.
//

import UnsplashPhotoPicker
import RxSwift
import RxCocoa

protocol HomeViewModelInput {
    func viewDidLoad()
}

protocol HomeViewModelOutput {
//    var photos: PublishSubject<[UnsplashPhoto]> { get }
    var photos: BehaviorRelay<[UnsplashPhoto]> { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}

final class DefaultHomeViewModel: HomeViewModel {
    private let disposeBag = DisposeBag()
//    private(set) var photos = PublishSubject<[UnsplashPhoto]>()
    private(set) var photos = BehaviorRelay<[UnsplashPhoto]>(value: [])
    
    init() {
        
    }
    
    func viewDidLoad() {
        let api = UnsplashAPI()
        api.execute()
            .subscribe { result in
//                self.photos.onNext(result)
                self.photos.accept(result)
            } onFailure: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    func changeTopic(to topic: Topic) {
        let api = UnsplashTopicAPI(topic: topic)
        api.execute()
            .subscribe { result in
//                self.photos.onNext(result)
                self.photos.accept(result)
            } onFailure: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
