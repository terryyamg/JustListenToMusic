//
//  MainViewModel.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/22.
//

import Foundation
import OrderedCollections

class MainViewModel: ObservableObject {

    var musicList: [MusicData] = []
    var folderList: OrderedDictionary<MusicType, [MusicData]> = [:]

    init() {
        musicList = getFiles()
        MusicType.allCases.forEach { musicType in
            folderList[musicType] = musicList.filter({ $0.type == musicType })
        }
    }

    func getFiles() -> [MusicData] {
        var musicList: [MusicData] = []
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
                musicList.append(MusicData(id: index, type: type, title: item.replacingOccurrences(of: ".mp3", with: "")))
            }
        } catch {
            print("getFiles error")
        }
        return musicList
    }
}
