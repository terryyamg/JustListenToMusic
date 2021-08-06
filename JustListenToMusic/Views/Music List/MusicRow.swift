//
//  MusicRow.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/20.
//

import SwiftUI
import AVKit
import Lottie

struct MusicRow: View {
    @ObservedObject var viewModel: MusicRowViewModel
    @State var looper: AVPlayerLooper?
    @Binding var selected: String?
    @State var isPlay: Bool = false
    
    var musicData: MusicData
    
    var body: some View {
        HStack {
            VStack {
                Text(musicData.title)
                    .fontWeight(.bold)
                    .font(.system(.body, design: .rounded))
                    .minimumScaleFactor(0.5)
                    .lineLimit(2)
                    .padding()
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .leading
                    )
                HStack {
                    if selected == musicData.title {
                        ForEach((1...3).reversed(), id: \.self) {
                            MusicPlayingView(name: "walking0\($0)", loopMode: .loop)
                                .frame(width: 60, height: 60)
                        }
                    }
                }
                
            }
            Spacer()
            // 循環播放
            if isPlay && selected == musicData.title {
                Image(systemName: "stop.fill")
                    .onTapGesture {
                        withAnimation {
                            viewModel.stopAll()
                            isPlay.toggle()
                        }
                    }
                    .foregroundColor(.red)
                    .padding(.all, 12)
                    .padding([.trailing, .leading], 12)
                    .overlay(Circle().stroke(Color.red, lineWidth: 3))
                    .shadow(color: .gray, radius: 2.0, x: 2.0, y: 2.0)
            } else {
                Image(systemName: "repeat" )
                    .onTapGesture {
                        withAnimation {
                            viewModel.stopAll()
                            looper = viewModel.playLoop(musicData.title)
                            MusicRowViewModel.avQueuePlayer?.play()
                            selected = musicData.title
                            isPlay.toggle()
                        }
                        print("Play loop")
                    }
                    .foregroundColor(.blue)
                    .padding(.all, 12)
                    .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                    .shadow(color: .gray, radius: 2.0, x: 2.0, y: 2.0)
                
                // 播放
                Image(systemName: "play.fill")
                    .onTapGesture {
                        withAnimation {
                            viewModel.stopAll()
                            viewModel.playSounds(musicData.title)
                            selected = musicData.title
                            isPlay.toggle()
                        }
                        print("Play one")
                    }
                    .foregroundColor(.red)
                    .padding(.all, 12)
                    .padding([.trailing, .leading], 12)
                    .overlay(Circle().stroke(Color.red, lineWidth: 3))
                    .shadow(color: .gray, radius: 2.0, x: 2.0, y: 2.0)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(selected == musicData.title ? Color.blue : Color.clear, lineWidth: 3)
        )
        .frame(height: 120)
    }
}

struct MusicRow_Previews: PreviewProvider {
    static var previews: some View {
        let title = "我們的歌"
        MusicRow(viewModel: MusicRowViewModel(soundFiles: []),
                 selected: .constant(title),
                 musicData: MusicData(id: 0, type: .chinese, title: title))
            .previewLayout(.sizeThatFits)
    }
}
