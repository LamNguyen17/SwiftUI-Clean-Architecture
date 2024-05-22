//
//  PhotoDataSourceImpl.swift
//  Photo-MVVM
//
//  Created by Lam Nguyen Tuan on 22/5/24.
//

import Foundation

enum PhotoDataSourceImpl: APIGateway {
    case getPhotoDataSource(searchTerm: String, pageSize: Int)

    var path: String {
        switch self {
        case .getPhotoDataSource(let searchTerm, let pageSize):
            return "?key=\(AppConfig.current.apiKey)&q=\(searchTerm)&page=\(pageSize)&per_page=20"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPhotoDataSource:
            return .get
        }
    }
}
