//
//  PhotoUseCase.swift
//  Photo-MVVM
//
//  Created by Lam Nguyen Tuan on 22/5/24.
//

import RxSwift

protocol PhotoUseCase {
    func getPhoto(searchTerm: String, pageSize: Int) -> Observable<PhotoResult>
}

