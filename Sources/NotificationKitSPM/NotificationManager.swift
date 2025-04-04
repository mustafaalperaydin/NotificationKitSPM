//
//  File.swift
//  
//
//  Created by Mustafa Alper Aydin on 20.01.2025.
//

import Foundation
import UserNotifications

protocol NotificationModelProtocol {
    var style: String? { get }
}

enum NotificationType {
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
    
    func parseNotification(userInfo: [AnyHashable: Any]) -> NotificationType? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: userInfo, options: []) else {
            return nil
        }
        
        if let style = userInfo["style"] as? String {
            switch style {
            case "Template4":
                if let notification = try? JSONDecoder().decode(NotificationModel4.self, from: jsonData) {
                    return .template4(notification)
                }
            case "Template3":
                if let notification = try? JSONDecoder().decode(NotificationModel3.self, from: jsonData) {
                    return .template3(notification)
                }
            case "Template2":
                if let notification = try? JSONDecoder().decode(NotificationModel2.self, from: jsonData) {
                    return .template2(notification)
                }
            default:
                return parseDefaultNotification(jsonData)
            }
        } else {
            return parseDefaultNotification(jsonData)
        }
    }
    
    func parseDefaultNotification(_ jsonData: Data) -> NotificationType {
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
}
