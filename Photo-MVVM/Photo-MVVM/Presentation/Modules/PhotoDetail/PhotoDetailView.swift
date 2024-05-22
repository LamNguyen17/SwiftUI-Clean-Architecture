//
//  PhotoDetailView.swift
//  Photo-MVVM
//
//  Created by Lam Nguyen Tuan on 22/5/24.
//

import SwiftUI
import Kingfisher

struct PhotoDetailView: View {
    @ObservedObject var viewModel: PhotoDetailViewModel

    var body: some View {
        VStack {
            KFImage(URL(string: "\(viewModel.photo.previewURL ?? "https://hws.dev/paul.jpg")"))
                .cacheOriginalImage()
                .placeholder { progress in
                    Image(systemName: "photo")
                        .imageScale(.large)
                        .frame(width: 100, height: 100)
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
                .frame(width: 100, height: 100)
            Text("\(viewModel.photo.user ?? "")").font(.headline).fontWeight(.bold)
            Text("Thẻ: \(viewModel.photo.tags ?? "")").font(.headline).fontWeight(.regular).lineLimit(1)
            Text("Lượt thích: \(String(viewModel.photo.likes))").font(.headline).fontWeight(.regular)
            Text("Bình luận: \(String(viewModel.photo.comments))").font(.headline).fontWeight(.regular)
        }
    }
}

