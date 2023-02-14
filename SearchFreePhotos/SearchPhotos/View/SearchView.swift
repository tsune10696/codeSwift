//
//  SearchView.swift
//
//  Created by Ippei.T on 2023/01/19.
//

import SwiftUI
import LPColorUI

struct SearchView: View {
	@StateObject private var model = ViewModel.shared
	
	@State private var searchText: String = ""
	
	var body: some View {
		NavigationView {
			ScrollView {
				LazyVStack(spacing: 0) {
					if model.searchImages.isEmpty {
						placeholder
					}
					ForEach(model.searchImages) { photo in
						PhotoCard(photo: photo)
							.onAppear {
								if photo == model.searchImages.last {
									model.getSearchImages(searchText, nextPage: true)
								}
							}

					}
				}
			}
			.navigationTitle("画像検索")
			.searchable(text: $searchText,
						placement: .navigationBarDrawer,
						prompt: "ここに単語を入力")
			.onSubmit(of: .search) {
				model.getSearchImages(searchText)
			}
			.onChange(of: searchText) { newValue in
				if searchText.isEmpty {
					model.setSearchImages([])
				}
			}
			.alert(model.notification?.title ?? "",
				   isPresented: $model.showNotification,
				   actions: {
				Button("OK") {
					model.removeNotification()
				}
			}, message: {
				VStack {
					Text(model.notification?.message ?? "")
				}
			})
		}
	}
	
    //検索画面の初期画面
	var placeholder: some View {
		VStack(spacing: 16) {
			Image(systemName: "magnifyingglass")
				.font(.largeTitle.weight(.semibold))
				.imageScale(.large)
			Text("検索のヒント：\n英単語で検索した方が\n多くの画像を見つけることができます\n(「air」「ice」など)")
				.font(.callout)
                .multilineTextAlignment(.center)
		}
		.foregroundColor(.tertiary)
		.frame(height: 400)
	}
}
