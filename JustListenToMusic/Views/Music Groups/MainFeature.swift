//
//  MainViewModel.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/22.
//

import Foundation
import OrderedCollections
import ComposableArchitecture

@Reducer
struct MainFeature {
    @ObservableState
    struct State: Equatable {
        public var musicList: [MusicData] = []
        public var folderList: OrderedDictionary<MusicType, [MusicData]> = [:]
        public var musicListStates: OrderedDictionary<MusicType, MusicListFeature.State> = [:]
    }
    
    enum Action: Equatable {
        case getFiles
        case success(data: [MusicData])
        case fail
        case musicList(MusicType, MusicListFeature.Action)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .getFiles:
            var data: [MusicData] = []
            let fileManager = FileManager.default
            let path = Bundle.main.resourcePath!
            do {
                let items = try fileManager.contentsOfDirectory(atPath: path)
                for (index, item) in items.enumerated() where item.contains("mp3") {
                    var type: MusicType = .chinese
                    switch item {
                    case let title where title.contains("(日)"):
                        type = .japan
                    case let title where title.contains("(Game)"):
                        type = .game
                    default:
                        type = .chinese
                    }
                    data.append(MusicData(id: index, type: type, title: item.replacingOccurrences(of: ".mp3", with: "")))
                }
                return .send(.success(data: data))
            } catch {
                return .send(.fail)
            }
        case .success(let data):
            state.musicList = data
            MusicType.allCases.forEach { musicType in
                let filteredData = data.filter({ $0.type == musicType })
                state.folderList[musicType] = filteredData
                state.musicListStates[musicType] = MusicListFeature.State(musicList: filteredData)
            }
            return .none
        case .fail:
            print("getFiles error")
            return .none
        case .musicList(let type, let action):
            return .none
        }
    }
}
