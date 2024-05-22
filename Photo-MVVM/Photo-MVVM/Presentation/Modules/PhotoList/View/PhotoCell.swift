//
//  PhotoCell.swift
//  Photo-MVVM
//
//  Created by Lam Nguyen Tuan on 22/5/24.
//

import SwiftUI
import Kingfisher

struct PhotoCell: View {
    @State var photo: Hits
    var body: some View {
        HStack {
            KFImage(URL(string: "\(photo.previewURL ?? "https://hws.dev/paul.jpg")"))
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
            VStack(alignment: .leading) {
                Text("\(photo.user ?? "")").font(.headline).fontWeight(.bold)
                Text("Thẻ: \(photo.tags ?? "")").font(.headline).fontWeight(.regular).lineLimit(1)
                Text("Lượt thích: \(String(photo.likes))").font(.headline).fontWeight(.regular)
                Text("Bình luận: \(String(photo.comments))").font(.headline).fontWeight(.regular)
            }.padding(.leading, 10)
        }.frame(alignment: .leading)
    }
}

