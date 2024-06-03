//
//  MainView.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/20.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            let columns: [GridItem] =  Array(repeating: .init(.flexible()), count: 2)
            
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16.0) {
                        ForEach(viewStore.folderList.keys, id: \.self) { key in
                            let list = viewStore.folderList[key] ?? []
                            NavigationLink(destination: MusicList(viewModel: .init(list), folderName: key.rawValue)) {
                                FolderView(folderName: key.rawValue)
                            }
                        }
                    }
                }
                .navigationTitle("Folder")
            }
            .onAppear {
                store.send(.getFiles)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(store: StoreOf<AppFeature>(initialState: AppFeature.State(), reducer: {
            AppFeature()
        }))
    }
}
