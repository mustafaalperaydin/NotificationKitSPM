//
//  File.swift
//  
//
//  Created by Mustafa Alper Aydin on 20.01.2025.
//

import Foundation

public struct NotificationResponseModel : Codable, Hashable{
    
    public var Type1: Int? = -1
    public var MxRouteId: Int? = -1
    public var MxBlockId: Int? = -1
    public var BlockStatusId: Int? = -1
    public var BlockExecutionStatusId: Int? = -1
    public var BlockActionDesc: String? = ""
    public var PointStatusId: Int? = -1
    public var PointId: Int? = -1
    public var Show: Int? = -1
    public var ActionDesc: String? = ""
    public var UseSandBox: Int? = -1
    public var ExecutionType: Int? = -1

    public init(){ }
    
    public init(Type1: Int?, MxRouteId: Int?, MxBlockId: Int?, BlockStatusId: Int?, BlockExecutionStatusId: Int?, BlockActionDesc: String?, PointStatusId: Int?, PointId: Int?, Show: Int?, ActionDesc: String?, UseSandBox: Int?, ExecutionType: Int?){
        
        self.Type1 = Type1
        self.MxRouteId = MxRouteId
        self.MxBlockId = MxBlockId
        self.BlockStatusId = BlockStatusId
        self.BlockExecutionStatusId = BlockExecutionStatusId
        self.BlockActionDesc = BlockActionDesc
        self.PointStatusId = PointStatusId
        self.PointId = PointId
        self.Show = Show
        self.ActionDesc = ActionDesc
        self.UseSandBox = UseSandBox
        self.ExecutionType = ExecutionType
    
    }
    
    enum CodingKeys: String, CodingKey {
        
        case Type1 = "Type"
        case MxRouteId, MxBlockId, BlockStatusId, BlockExecutionStatusId, BlockActionDesc, PointStatusId, PointId, Show, ActionDesc, UseSandBox, ExecutionType
        
    }
}
