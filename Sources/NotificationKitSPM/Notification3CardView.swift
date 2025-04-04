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
    
    @Binding var notification3Dialog: Bool
    var notification3Model: NotificationModel3
    
    public init(notification3Dialog: Binding<Bool>, notification3Model: NotificationModel3) {
        self._notification3Dialog = notification3Dialog
        self.notification3Model = notification3Model
    }
    
    public var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            notification3Dialog = false
                        }
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(notification3Model.closeBtnColor == "" ? .black : Color.init(hex1: notification3Model.closeBtnColor!))
                    })
                }.padding(5)
                
                if notification3Model.imageUrl != "" {
                    AsyncImageView(url: URL(string: notification3Model.imageUrl!)!, width: 150, height: 150)
                } else if notification3Model.videoUrl != "" {
                    AsyncVideoView(url: URL(string: notification3Model.videoUrl!)!)
                } else if notification3Model.lottieName != "" {
                    LottieView(name: notification3Model.lottieName!)
                        .frame(maxHeight: 250)
                }
                
                
                VStack(spacing: 5) {
                    Text(notification3Model.title ?? "")
                        .foregroundColor(notification3Model.titleColor == "" ? .black : Color.init(hex1: notification3Model.titleColor!))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.headline)
                        .font(.system(size: 24))
                    
                    Text(notification3Model.body ?? "")
                        .foregroundColor(notification3Model.bodyColor == "" ? .black : Color.init(hex1: notification3Model.bodyColor!))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.callout)
                        .font(.system(size: 14))
                        .lineLimit(2)
                    
                }
                
                if notification3Model.actionBtnText != "" {
                    Text(notification3Model.actionBtnText ?? "")
                        .foregroundColor(notification3Model.actionBtnTextColor == "" ? .black : Color.init(hex1: notification3Model.actionBtnTextColor!))
                        .frame(width: 150)
                        .font(.callout)
                        .font(.system(size: 14))
                        .padding(.vertical, 10)
                        .background(notification3Model.actionBtnBgColor == "" ? .blue : Color.init(hex1: notification3Model.actionBtnBgColor!))
                        .cornerRadius(10)
                }
                
            }.padding(5)
                .background(notification3Model.cardBgColor == "" ? .white : Color.init(hex1: notification3Model.cardBgColor!))
                .cornerRadius(CGFloat(notification3Model.cardRadius == -1 ? 10 : notification3Model.cardRadius!))
                .padding(10)
                .onAppear {
                    if notification3Model.sound != "" {
                        playSound(sound: notification3Model.sound!)
                    }
                }
        }
    }
}

public struct AsyncVideoView: View {
    let url: URL
    
    public var body: some View {
        VideoPlayer(player: AVPlayer(url: url))
            .frame(height: 200)
            .onAppear {
                // Oynatıcıyı başlat
                AVPlayer(url: url).play()
            }
    }
}

public struct LottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode
    var animationSpeed: CGFloat
    var type: Int
    
    public init(name: String, loopMode: LottieLoopMode = .playOnce, animationSpeed: CGFloat = 1, type: Int = 0) {
        self.name = name
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
        self.type = type
    }
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.logHierarchyKeypaths()
        
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(animationView)
                NSLayoutConstraint.activate([
                    animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
                    animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
                ])
        return view
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
