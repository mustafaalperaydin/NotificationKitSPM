//
//  File.swift
//  
//
//  Created by Mustafa Alper Aydin on 20.01.2025.
//

import Foundation
import UserNotifications

public class NotificationManager {
    public static let shared = NotificationManager()
    
    private init() {}
    
    @available(macOS 10.14, *)
    public func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            completion(granted, error)
            //test test test
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
