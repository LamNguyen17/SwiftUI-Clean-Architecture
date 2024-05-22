//
//  PhotoDetailViewModel.swift
//  Photo-MVVM
//
//  Created by Lam Nguyen Tuan on 22/5/24.
//

import Foundation

final class PhotoDetailViewModel: ObservableObject {
    @Published private(set) var photo: Hits

    init(photo: Hits) {
        self.photo = photo
    }
}
