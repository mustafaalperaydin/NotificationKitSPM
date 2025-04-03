//
//  File.swift
//  
//
//  Created by Mustafa Alper Aydin on 20.01.2025.
//

import Foundation
import SwiftUI
import AVKit
import Lottie

public struct Notification3CardView: View {
    
    @Binding var notification4Dialog: Bool
    var notification4Model: NotificationModel4
    
    public init(notification4Dialog: Binding<Bool>, notification4Model: NotificationModel4) {
        self._notification4Dialog = notification4Dialog
        self.notification4Model = notification4Model
    }
    
    public var body: some View {
        ZStack {
            VStack {
                if notification4Model.location! == "CENTER" || notification4Model.location! == "BOTTOM"
                {
                    Spacer()
                }
                
                HStack {
                    VStack(spacing: 5) {
                        Text(notification4Model.title ?? "")
                            .foregroundColor(notification4Model.titleColor == "" ? .black : Color.init(hex1: notification4Model.titleColor!))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .font(.system(size: 24))
                        
                        Text(notification4Model.body ?? "")
                            .foregroundColor(notification4Model.bodyColor == "" ? .black : Color.init(hex1: notification4Model.bodyColor!))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .font(.system(size: 14))
                            .lineLimit(2)
                    }.padding(10)
                        .background(notification4Model.cardBgColor == "" ? .gray.opacity(0.3) : Color.init(hex1: notification4Model.cardBgColor!))
                    
                    if notification4Model.lottieName != "" {
                        LottieView(name: notification4Model.lottieName!, loopMode: .loop)
                            .frame(width: notification4Model.lottieSizeX == -1 ? 100 : CGFloat(notification4Model.lottieSizeX!))
                            .frame(height: notification4Model.lottieSizeY == -1 ? 100 : CGFloat(notification4Model.lottieSizeY!))
                    }
                    
                }.padding(.horizontal, 10)
                    .onTapGesture {
                        withAnimation {
                            notification4Dialog = false
                        }
                    }
                
                if notification4Model.location! == "CENTER" || notification4Model.location! == "TOP"
                {
                    Spacer()
                }
            }.onAppear {
                if notification4Model.sound != "" {
                    playSound(sound: notification4Model.sound!, type: "wav")
                }
            }
                
        }
    }
}

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            
        }
    }
}
