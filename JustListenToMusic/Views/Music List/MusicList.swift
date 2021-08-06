//
//  MusicList.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/20.
//

import SwiftUI

struct MusicList: View {
    @ObservedObject var viewModel: MusicListViewModel
    @State var selected: String?
    var folderName: String = ""
    
    var body: some View {
        List(viewModel.musicList) { musicData in
            HStack {
                MusicRow(viewModel: MusicRowViewModel(soundFiles: viewModel.musicList.map({ $0.title })),
                         selected: $selected,
                         musicData: musicData)
            }
        }
        .navigationTitle(folderName)
    }
}

struct MusicList_Previews: PreviewProvider {
    static var previews: some View {
        MusicList(viewModel: .init([MusicData(id: 0, type: .chinese, title: "第一首歌"),
                                    MusicData(id: 1, type: .chinese, title: "第二首歌")]))
    }
}
