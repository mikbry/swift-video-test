//
//  Player.swift
//  videoprocess
//
//  Created by Mik on 01/10/2020.
//

import AVKit
import SwiftUI

struct PlayerView: UIViewRepresentable {
    let player: AVPlayer
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
        (uiView as? PlayerUIView)?.updatePlayer(player: player)
    }

    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(player: player)
    }
}

class PlayerUIView: UIView {

    private let playerLayer = AVPlayerLayer()

    init(player: AVPlayer) {
        super.init(frame: .zero)

        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    func updatePlayer(player: AVPlayer) {
        self.playerLayer.player = player
    }
}

struct PlayerContainerView : View {

    @State var seekPos = 0.0

    private let player: AVPlayer

    init(player: AVPlayer) {
        self.player = player
    }

    var body: some View {
        VStack {
            PlayerView(player: player)
            PlayerControlsView(player: player)
        }
    }
}

struct PlayerControlsView : View {

    @State var playerPaused = true
    @State var seekPos = 0.0
    let player: AVPlayer

    var body: some View {
        HStack {
            Button(action: {
                self.playerPaused.toggle()
                if self.playerPaused {
                    self.player.pause()
                }
                else {
                    self.player.play()
                }
            }) {
                Image(systemName: playerPaused ? "play" : "pause")
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
            }
            Slider(value: $seekPos, in: 0...1, onEditingChanged: { _ in
                guard let item = self.player.currentItem else {
                    return
                }

                let targetTime = self.seekPos * item.duration.seconds
                self.player.seek(to: CMTime(seconds: targetTime, preferredTimescale: 600))
            })
                .padding(.trailing, 20)
        }
    }
}
