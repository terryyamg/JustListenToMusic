//
//  MainViewModel.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/22.
//

import Foundation
import OrderedCollections
import ComposableArchitecture

struct AppFeature: Reducer {
    struct State: Equatable {
        public var musicList: [MusicData] = []
        public var folderList: OrderedDictionary<MusicType, [MusicData]> = [:]
    }
    
    enum Action: Equatable {
        case getFiles
        case success(data: [MusicData])
        case fail
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
                state.folderList[musicType] = data.filter({ $0.type == musicType })
            }
            return .none
        case .fail:
            print("getFiles error")
            return .none
        }
    }
}
