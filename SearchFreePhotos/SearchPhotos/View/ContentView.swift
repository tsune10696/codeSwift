//
//  ContentView.swift
//  SearchFreePhotos
//
//  Created by tsune on 2023/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedView: Environment.TabViewTag = .curated
    
    var body: some View {
        TabView(selection: $selectedView) {
            SearchView()
                .tabItem {
                    Label("検索", systemImage: "magnifyingglass")
                        .environment(\.symbolVariants, selectedView == .search ? .fill : .none)
                }
                .tag(Environment.TabViewTag.search)
        }
    }
}
