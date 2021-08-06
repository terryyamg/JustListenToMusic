//
//  MainView.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/20.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        let columns: [GridItem] =  Array(repeating: .init(.flexible()), count: 2)
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16.0) {
                    ForEach(viewModel.folderList.keys, id: \.self) { key in
                        let list = viewModel.folderList[key] ?? []
                        NavigationLink(destination: MusicList(viewModel: .init(list), folderName: key.rawValue)) {
                            FolderView(folderName: key.rawValue)
                        }
                    }
                }
            }
            .navigationTitle("Folder")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
