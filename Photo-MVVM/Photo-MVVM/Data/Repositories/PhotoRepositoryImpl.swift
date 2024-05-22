//
//  PhotoRepositoryImpl.swift
//  Photo-MVVM
//
//  Created by Lam Nguyen Tuan on 22/5/24.
//

import Foundation
import RxSwift
import Alamofire

struct PhotoResult: Decodable {
    var hits: [Hits]
    var total: Int
    var totalHits: Int
}

struct PhotoRepository: PhotoUseCase {
    func getPhoto(searchTerm: String, pageSize: Int) -> Observable<PhotoResult>{
        return PhotoDataSourceImpl.getPhotoDataSource(searchTerm: searchTerm, pageSize: 1).request(returnType: PhotoResult.self)
    }
}
