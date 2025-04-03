//
//  File.swift
//  
//
//  Created by Mustafa Alper Aydin on 20.01.2025.
//

import Foundation
import SwiftUI

public struct Notification2CardView: View {
    
    @Binding var notification2Dialog: Bool
    var notification2Model: NotificationModel2
    
    public init(notification2Dialog: Binding<Bool>, notification2Model: NotificationModel2) {
        self._notification2Dialog = notification2Dialog
        self.notification2Model = notification2Model
    }
    
    public var body: some View {
        ZStack {
            VStack {
                if notification2Model.location! == "CENTER" || notification2Model.location! == "BOTTOM"
                {
                    Spacer()
                }
                HStack(spacing: 0) {
                    
                    HStack {
                        
                    }.frame(width: 10, height: 80)
                        .background(notification2Model.startLineColor == "" ? .green : Color.init(hex1: notification2Model.startLineColor!))
                    
                    if notification2Model.startImageUrl == "" {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(notification2Model.closeBtnColor == "" ? .green : Color.init(hex1: notification2Model.closeBtnColor!))
                            .padding(.horizontal, 5)
                    } else {
                        AsyncImageView(url: URL(string: notification2Model.startImageUrl!)!)
                            .padding(.horizontal, 5)
                    }
                    
                    
                    VStack(spacing: 5) {
                        Text(notification2Model.title ?? "")
                            .foregroundColor(notification2Model.titleColor == "" ? .black : Color.init(hex1: notification2Model.titleColor!))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .font(.system(size: 24))
                        
                        Text(notification2Model.body ?? "")
                            .foregroundColor(notification2Model.bodyColor == "" ? .black : Color.init(hex1: notification2Model.bodyColor!))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                            .font(.system(size: 14))
                            .lineLimit(2)
                        
                    }
                    
                    Button(action: {
                        withAnimation {
                            notification2Dialog = false
                        }
                    }, label: {
                        if notification2Model.startImageUrl == "" {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(notification2Model.closeBtnColor == "" ? .black : Color.init(hex1: notification2Model.closeBtnColor!))
                                .padding(.horizontal, 5)
                        } else {
                            AsyncImageView(url: URL(string: notification2Model.startImageUrl!)!)
                                .padding(.horizontal, 5)
                        }
                    })
                    
                }.frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(notification2Model.cardBgColor == "" ? .white : Color.init(hex1: notification2Model.cardBgColor!))
                    .cornerRadius(10)
                    .padding()
                
                if notification2Model.location! == "CENTER" || notification2Model.location! == "TOP"
                {
                    Spacer()
                }
            }
            
        }
    }
}



extension Color {
    
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {

        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            // You can handle the failure here as you want
            return (0, 0, 0, 0)
        }

        return (r, g, b, o)
    }
    
    
    init(hex1: String) {
        let hex = hex1.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

import SwiftUI
import Combine

struct AsyncImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    let url: URL
    var width: CGFloat = 25
    var height: CGFloat = 25
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: width, height: height)
            }
        }
        .onAppear {
            imageLoader.load(url: url)
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    private var cancellable: AnyCancellable? = nil
    
    func load(url: URL) {
        // Öncelikle URL'den gelen veriyi yükleyelim
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ in
                UIImage(data: data)
            }
            .compactMap { $0 }
            .map { Image(uiImage: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { self.image = $0 })
    }
}

