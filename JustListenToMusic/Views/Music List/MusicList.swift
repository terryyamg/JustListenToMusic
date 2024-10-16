//
//  MusicList.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/20.
//

import SwiftUI
import ComposableArchitecture

struct MusicList: View {
    let store: StoreOf<MusicListFeature>
    
    @State var selected: String?
    var folderName: String = ""
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List(viewStore.musicList) { musicData in
                HStack {
                    MusicRow(viewModel: MusicRowViewModel(soundFiles: viewStore.musicList.map({ $0.title })),
                             selected: $selected,
                             musicData: musicData)
                }
            }
            .navigationTitle(folderName)
        }
    }
}

struct MusicList_Previews: PreviewProvider {
    static var previews: some View {
        MusicList(store: StoreOf<MusicListFeature>(initialState: MusicListFeature.State(), reducer: {
            MusicListFeature()
        }))
    }
}
