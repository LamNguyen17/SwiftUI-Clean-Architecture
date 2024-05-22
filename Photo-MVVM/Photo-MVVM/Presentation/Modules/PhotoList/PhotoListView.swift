//
//  PhotoListView.swift
//  Photo-MVVM
//
//  Created by Lam Nguyen Tuan on 22/5/24.
//

import SwiftUI
import RxSwift
import RxCocoa
import Kingfisher

struct PhotoListView: View {
    @ObservedObject var viewModel = PhotoListViewModel()
    @State private var searchTerm: String = ""
    @State private var isLoading = false
    
    @State private var isFinished = false
    
    var body: some View {
        NavigationStack {
            TextField("Enter keyword", text: $searchTerm)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: searchTerm) {
                    viewModel.input.search.accept(searchTerm)
                }
            if viewModel.output.isFetching {
                ProgressView()
            }
            List {
                ForEach(0 ..< viewModel.output.results!.count, id: \.self) { index in
                    NavigationLink(destination: PhotoDetailView(viewModel: PhotoDetailViewModel(photo: viewModel.output.results![index]))) {
                        PhotoCell(photo: viewModel.output.results![index])
                    }
                }
            }
            .navigationTitle("My Photo Pixabay")
        }
    }
    
}

