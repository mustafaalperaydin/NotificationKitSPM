//
//  File.swift
//  
//
//  Created by Mustafa Alper Aydin on 20.01.2025.
//

import Foundation
import UserNotifications

public protocol NotificationModelProtocol {
    var style: String? { get }
}

public enum NotificationType {
    case template4(NotificationModel4)
    case template3(NotificationModel3)
    case template2(NotificationModel2)
    case defaultModel(NotificationResponseModel)
}

public class NotificationManager {
    public static let shared = NotificationManager()
    
    private init() {}
    
    @available(macOS 10.14, *)
    public func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            completion(granted, error)
        }
    }
    
    public func parseNotification(userInfo: [AnyHashable: Any]) -> NotificationType? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: userInfo, options: []) else {
            return nil
        }
        
        if let style = userInfo["style"] as? String {
            switch style {
            case "Template4":
                if let notification = try? JSONDecoder().decode(NotificationModel4.self, from: jsonData) {
                    return .template4(notification)
                } else {
                    return parseDefaultNotification(jsonData)
                }
            case "Template3":
                if let notification = try? JSONDecoder().decode(NotificationModel3.self, from: jsonData) {
                    return .template3(notification)
                } else {
                    return parseDefaultNotification(jsonData)
                }
            case "Template2":
                if let notification = try? JSONDecoder().decode(NotificationModel2.self, from: jsonData) {
                    return .template2(notification)
                } else {
                    return parseDefaultNotification(jsonData)
                }
            default:
                return parseDefaultNotification(jsonData)
            }
        } else {
            return parseDefaultNotification(jsonData)
        }
    }
    
    public func parseDefaultNotification(_ jsonData: Data) -> NotificationType {
        if let notification = try? JSONDecoder().decode(NotificationResponseModel.self, from: jsonData) {
            return .defaultModel(notification)
        } else {
            return .defaultModel(NotificationResponseModel()) // Varsayılan boş model
        }
    }
    
    public func handleResponseNotification(userInfo: [AnyHashable: Any]) -> NotificationResponseModel? {
        print("✅handleResponseNotification")
        var notfModel: NotificationResponseModel = NotificationResponseModel()
        print("🍀userInfo - \(userInfo)")
        for notf in userInfo {
            print("⚠️notf - \(notf)")
            if notf.key.description == "Type" {
                notfModel.Type1 = Int(notf.value as! String)
            } else if notf.key.description == "MxRouteId" {
                notfModel.MxRouteId = Int(notf.value as! String)
            } else if notf.key.description == "MxBlockId" {
                notfModel.MxBlockId = Int(notf.value as! String)
            } else if notf.key.description == "BlockStatusId" {
                notfModel.BlockStatusId = Int(notf.value as! String)
            } else if notf.key.description == "BlockExecutionStatusId" {
                notfModel.BlockExecutionStatusId = Int(notf.value as! String)
            } else if notf.key.description == "BlockActionDesc" {
                notfModel.BlockActionDesc = notf.value as? String
            } else if notf.key.description == "PointStatusId" {
                notfModel.PointStatusId = Int(notf.value as! String)
            } else if notf.key.description == "PointId" {
                notfModel.PointId = Int(notf.value as! String)
            } else if notf.key.description == "Show" {
                notfModel.Show = Int(notf.value as! String)
            } else if notf.key.description == "ActionDesc" {
                notfModel.ActionDesc = notf.value as? String
            } else if notf.key.description == "UseSandBox" {
                notfModel.UseSandBox = Int(notf.value as! String)
            } else if notf.key.description == "ExecutionType" {
                notfModel.ExecutionType = Int(notf.value as! String)
            }
        }
        print("🍕notfModel - \(notfModel)")
        return notfModel
    }
    
    public func handleNotification2(userInfo: [AnyHashable: Any]) -> NotificationModel2? {
        print("✅handleNewNotification")
        var model = NotificationModel2()
        print("🍀userInfo - \(userInfo)")
        
        for notf in userInfo {
            print("⚠️notf - \(notf)")
            switch notf.key.description {
            case "Type":
                model.Type1 = Int(notf.value as? String ?? "")
            case "style":
                model.style = notf.value as? String
            case "mxRouteId":
                model.mxRouteId = Int(notf.value as? String ?? "")
            case "mxBlockId":
                model.mxBlockId = Int(notf.value as? String ?? "")
            case "pointId":
                model.pointId = Int(notf.value as? String ?? "")
            case "title":
                model.title = notf.value as? String
            case "body":
                model.body = notf.value as? String
            case "startImageUrl":
                model.startImageUrl = notf.value as? String
            case "closeImageUrl":
                model.closeImageUrl = notf.value as? String
            case "titleColor":
                model.titleColor = notf.value as? String
            case "bodyColor":
                model.bodyColor = notf.value as? String
            case "closeBtnColor":
                model.closeBtnColor = notf.value as? String
            case "cardBgColor":
                model.cardBgColor = notf.value as? String
            case "cardMarginVertical":
                model.cardMarginVertical = Int(notf.value as? String ?? "")
            case "cardMarginHorizontal":
                model.cardMarginHorizontal = Int(notf.value as? String ?? "")
            case "startLineColor":
                model.startLineColor = notf.value as? String
            case "sound":
                model.sound = notf.value as? String
            case "vibrate":
                model.vibrate = Int(notf.value as? String ?? "")
            case "clickAction":
                model.clickAction = notf.value as? String
            case "location":
                model.location = notf.value as? String
            default:
                break
            }
        }

        print("🍕model - \(model)")
        return model
    }
    
    public func handleNotification3(userInfo: [AnyHashable: Any]) -> NotificationModel3? {
        print("✅handleAdvancedNotification")
        var model = NotificationModel3()
        print("🍀userInfo - \(userInfo)")
        
        for notf in userInfo {
            print("⚠️notf - \(notf)")
            switch notf.key.description {
            case "Type":
                model.Type1 = Int(notf.value as? String ?? "")
            case "style":
                model.style = notf.value as? String
            case "notificationId":
                model.notificationId = Int(notf.value as? String ?? "")
            case "mxRouteId":
                model.mxRouteId = Int(notf.value as? String ?? "")
            case "mxBlockId":
                model.mxBlockId = Int(notf.value as? String ?? "")
            case "pointId":
                model.pointId = Int(notf.value as? String ?? "")
            case "title":
                model.title = notf.value as? String
            case "body":
                model.body = notf.value as? String
            case "imageUrl":
                model.imageUrl = notf.value as? String
            case "videoUrl":
                model.videoUrl = notf.value as? String
            case "lottieName":
                model.lottieName = notf.value as? String
            case "gifUrl":
                model.gifUrl = notf.value as? String
            case "actionBtnText":
                model.actionBtnText = notf.value as? String
            case "textField":
                model.textField = notf.value as? String
            case "cardBgColor":
                model.cardBgColor = notf.value as? String
            case "cardRadius":
                model.cardRadius = Int(notf.value as? String ?? "")
            case "headerBgColor":
                model.headerBgColor = notf.value as? String
            case "titleColor":
                model.titleColor = notf.value as? String
            case "bodyColor":
                model.bodyColor = notf.value as? String
            case "closeBtnColor":
                model.closeBtnColor = notf.value as? String
            case "actionBtnBgColor":
                model.actionBtnBgColor = notf.value as? String
            case "actionBtnTextColor":
                model.actionBtnTextColor = notf.value as? String
            case "headerPadding":
                model.headerPadding = Int(notf.value as? String ?? "")
            case "dialogMarginVertical":
                model.dialogMarginVertical = Int(notf.value as? String ?? "")
            case "dialogMarginHorizontal":
                model.dialogMarginHorizontal = Int(notf.value as? String ?? "")
            case "sound":
                model.sound = notf.value as? String
            case "vibrate":
                model.vibrate = Int(notf.value as? String ?? "")
            case "clickAction":
                model.clickAction = notf.value as? String
            default:
                break
            }
        }
        
        print("🍕model - \(model)")
        return model
    }
    
    public func handleNotification4(userInfo: [AnyHashable: Any]) -> NotificationModel4? {
        print("✅handleUpdatedNotification")
        var model = NotificationModel4()
        print("🍀userInfo - \(userInfo)")
        
        for notf in userInfo {
            print("⚠️notf - \(notf)")
            switch notf.key.description {
            case "Type":
                model.Type1 = Int(notf.value as? String ?? "")
            case "style":
                model.style = notf.value as? String
            case "notificationId":
                model.notificationId = notf.value as? String
            case "mxRouteId":
                model.mxRouteId = Int(notf.value as? String ?? "")
            case "mxBlockId":
                model.mxBlockId = Int(notf.value as? String ?? "")
            case "pointId":
                model.pointId = Int(notf.value as? String ?? "")
            case "title":
                model.title = notf.value as? String
            case "body":
                model.body = notf.value as? String
            case "lottieName":
                model.lottieName = notf.value as? String
            case "lottieSizeX":
                model.lottieSizeX = Int(notf.value as? String ?? "")
            case "lottieSizeY":
                model.lottieSizeY = Int(notf.value as? String ?? "")
            case "actionBtnText":
                model.actionBtnText = notf.value as? String
            case "textField":
                model.textField = notf.value as? String
            case "cardBgColor":
                model.cardBgColor = notf.value as? String
            case "cardRadius":
                model.cardRadius = Int(notf.value as? String ?? "")
            case "headerBgColor":
                model.headerBgColor = notf.value as? String
            case "titleColor":
                model.titleColor = notf.value as? String
            case "bodyColor":
                model.bodyColor = notf.value as? String
            case "closeBtnColor":
                model.closeBtnColor = notf.value as? String
            case "actionBtnBgColor":
                model.actionBtnBgColor = notf.value as? String
            case "actionBtnTextColor":
                model.actionBtnTextColor = notf.value as? String
            case "headerPadding":
                model.headerPadding = Int(notf.value as? String ?? "")
            case "location":
                model.location = notf.value as? String
            case "marginVertical":
                model.marginVertical = Int(notf.value as? String ?? "")
            case "marginHorizontal":
                model.marginHorizontal = Int(notf.value as? String ?? "")
            case "sound":
                model.sound = notf.value as? String
            case "vibrate":
                model.vibrate = Int(notf.value as? String ?? "")
            case "clickAction":
                model.clickAction = notf.value as? String
            default:
                break
            }
        }
        
        print("🍕model - \(model)")
        return model
    }
}
