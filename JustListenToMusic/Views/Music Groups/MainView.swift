//
//  MainView.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/20.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let store: StoreOf<MainFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            let columns: [GridItem] =  Array(repeating: .init(.flexible()), count: 2)
            
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16.0) {
                        ForEach(viewStore.folderList.keys, id: \.self) { key in
                            NavigationLink(destination: MusicList(
                                store: store.scope(
                                    state: { state in
                                        state.musicListStates[key] ?? MusicListFeature.State()
                                    },
                                    action: { .musicList(key, $0) }
                                ),
                                folderName: key.rawValue
                            )) {
                                FolderView(folderName: key.rawValue)
                            }
                        }
                    }
                }
                .navigationTitle("Folder")
            }
            .onAppear {
                viewStore.send(.getFiles)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(store: StoreOf<MainFeature>(initialState: MainFeature.State(), reducer: {
            MainFeature()
        }))
    }
}
