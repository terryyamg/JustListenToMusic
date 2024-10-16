//
//  JustListenToMusicApp.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/26.
//

import SwiftUI
import ComposableArchitecture

@main
struct JustListenToMusicApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
                store: StoreOf<MainFeature>(initialState: MainFeature.State()) {
                    MainFeature()
                }
            )
        }
    }
}
