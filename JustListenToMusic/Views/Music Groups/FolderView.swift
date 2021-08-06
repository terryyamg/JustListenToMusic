//
//  FolderView.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/20.
//

import SwiftUI

struct FolderView: View {
    var folderName: String = ""

    var body: some View {
        VStack {
            Image(systemName: "music.quarternote.3")
                .resizable()
                .frame(width: 60.0, height: 60.0)
                .foregroundColor(.white)
            Text(folderName)
                .fontWeight(.bold)
                .font(.system(.title, design: .rounded))
                .foregroundColor(.black)
                .padding(.bottom, 8)
            
        }
        .frame(width: 160.0, height: 160.0)
        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
        .cornerRadius(10.0)
        .shadow(radius: 7)
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
            .previewLayout(.sizeThatFits)
    }
}
