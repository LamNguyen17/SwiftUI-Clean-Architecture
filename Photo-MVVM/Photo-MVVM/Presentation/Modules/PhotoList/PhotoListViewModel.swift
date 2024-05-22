//
//  PhotoListViewModel.swift
//  Photo-MVVM
//
//  Created by Lam Nguyen Tuan on 22/5/24.
//

import Foundation
import RxSwift
import RxCocoa


class PhotoListViewModel: ObservableObject {
    @Injected var photoUseCase: PhotoUseCase
    
    // Inputs
    struct Input {
        let loadMore: PublishRelay<Void>
        let search: PublishRelay<String>
    }
    
    // Outputs
    struct Output {
        var results: [Hits]?
        var errorMessage: String?
        var isFetching: Bool
    }
    
    let input: Input
    @Published var output: Output
    private let disposeBag = DisposeBag()
    
    init() {
        input = Input(loadMore: PublishRelay<Void>(), search: PublishRelay<String>())
        output = Output(results: [], errorMessage: "", isFetching: false)
        let currentPage = BehaviorRelay<Int>(value: 1)
        
        let loadMore = input.loadMore
            .do(onNext: {
                let nextPage = currentPage.value + 1
                currentPage.accept(nextPage)
            })
            .withLatestFrom(input.search)
        
        let search = input.search.do(onNext: {
            _ in currentPage.accept(1)
        })
        
        // There is operator flatMapLatest which does exactly the same as switchMap in RxJS.
        Observable.merge(search, loadMore)
            .debounce(.milliseconds(350), scheduler: MainScheduler.instance)
            .flatMapLatest { keyword in
                self.output.isFetching = true
                return self.photoUseCase.getPhoto(searchTerm: keyword, pageSize: 1)
            }
            .subscribe(onNext: { [weak self] users in
                self?.output.isFetching = false
                self?.output.results = users.hits
            }, onError: { [weak self] error in
                self?.output.isFetching = false
                self?.output.errorMessage = "\(error)"
            }).disposed(by: disposeBag)
    }
}

