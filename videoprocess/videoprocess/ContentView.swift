//
//  ContentView.swift
//  videoprocess
//
//  Created by Mik on 01/10/2020.
//

import AVKit
import SwiftUI

struct ContentView: View {
 
    @State private var isShowVideoPicker = false
    // @State private var image = UIImage()
    @State var url: URL?

    var body: some View {
        VStack {
            
            PlayerContainerView(player: AVPlayer(url: url ?? URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!))
            
            /* Image(uiImage: self.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all) */
 
            Button(action: {
                self.isShowVideoPicker = true
            }) {
                HStack {
                    Image(systemName: "video")
                        .font(.system(size: 20))
 
                    Text("Video library")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $isShowVideoPicker) {
            VideoPicker(sourceType: .photoLibrary, selectedUrl: self.$url)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
