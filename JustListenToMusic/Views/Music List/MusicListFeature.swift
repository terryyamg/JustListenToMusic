//
//  MusicListViewModel.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/22.
//

import Foundation
import ComposableArchitecture

struct MusicListFeature: Reducer {
    struct State: Equatable {
        public var musicList: [MusicData] = []
    }
    
    enum Action: Equatable {
        case setData(data: [MusicData])
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .setData(let data):
            state.musicList = data
            return .none
        }
    }
}
