//
//  File.swift
//  
//
//  Created by Mustafa Alper Aydin on 20.01.2025.
//

import Foundation

public struct NotificationModel4 : Codable, Hashable{
    
    public var Type1: Int? = -1
    public var style: String? = ""
    public var notificationId: String? = ""
    public var mxRouteId: Int? = -1
    public var mxBlockId: Int? = -1
    public var pointId: Int? = -1
    public var title: String? = ""
    public var body: String? = ""
    public var lottieName: String? = ""
    public var lottieSizeX: Int? = -1
    public var lottieSizeY: Int? = -1
    public var actionBtnText: String? = ""
    public var textField: String? = ""
    public var cardBgColor: String? = ""
    public var cardRadius: Int? = -1
    public var headerBgColor: String? = ""
    public var titleColor: String? = ""
    public var bodyColor: String? = ""
    public var closeBtnColor: String? = ""
    public var actionBtnBgColor: String? = ""
    public var actionBtnTextColor: String? = ""
    public var headerPadding: Int? = -1
    public var location: String? = ""
    public var marginVertical: Int? = -1
    public var marginHorizontal: Int? = -1
    public var sound: String? = ""
    public var vibrate: Int? = -1
    public var clickAction: String? = ""

    public init(){ }
    
    public init(Type1: Int?, style: String?, notificationId: String?, mxRouteId: Int?, mxBlockId: Int?, pointId: Int?, title: String?, body: String?, lottieName: String?, lottieSizeX: Int?, lottieSizeY: Int?, actionBtnText: String?, textField: String?, cardBgColor: String?, cardRadius: Int?, headerBgColor: String?, titleColor: String?, bodyColor: String?, closeBtnColor: String?, actionBtnBgColor: String?, actionBtnTextColor: String?, headerPadding: Int?, location: String?, marginVertical: Int?, marginHorizontal: Int?, sound: String?, vibrate: Int?, clickAction: String?) {
        
        self.Type1 = Type1
        self.style = style
        self.notificationId = notificationId
        self.mxRouteId = mxRouteId
        self.mxBlockId = mxBlockId
        self.pointId = pointId
        self.title = title
        self.body = body
        self.lottieName = lottieName
        self.lottieSizeX = lottieSizeX
        self.lottieSizeY = lottieSizeY
        self.actionBtnText = actionBtnText
        self.textField = textField
        self.cardBgColor = cardBgColor
        self.cardRadius = cardRadius
        self.headerBgColor = headerBgColor
        self.titleColor = titleColor
        self.bodyColor = bodyColor
        self.closeBtnColor = closeBtnColor
        self.actionBtnBgColor = actionBtnBgColor
        self.actionBtnTextColor = actionBtnTextColor
        self.headerPadding = headerPadding
        self.location = location
        self.marginVertical = marginVertical
        self.marginHorizontal = marginHorizontal
        self.sound = sound
        self.vibrate = vibrate
        self.clickAction = clickAction
    
    }
    
    enum CodingKeys: String, CodingKey {
        
        case Type1 = "Type"
        case style, notificationId, mxRouteId, mxBlockId, pointId, title, body, lottieName, lottieSizeX, lottieSizeY, actionBtnText, textField, cardBgColor, cardRadius, headerBgColor, titleColor, bodyColor, closeBtnColor, actionBtnBgColor, actionBtnTextColor, headerPadding, location, marginVertical, marginHorizontal, sound, vibrate, clickAction
        
    }
}
