//
//  AutomationSupportScaner.swift
//  CarDayAdminorIOS
//
//  Created by oliver.zhai on 2018/5/21.
//  Copyright © 2018年 HaiYang. All rights reserved.
//

public protocol AutomationSupportProtocol: class {
    static func awake()
}

class AutomationSupportScaner {
    //扫描所有的类，如果实现了AutomationSupportProtocol协议，那么调用其awake方法。
    static func scan(){
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let autoreleaseintTypes = AutoreleasingUnsafeMutablePointer<AnyClass?>(types)
        objc_getClassList(autoreleaseintTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? AutomationSupportProtocol.Type)?.awake()
        }
        types.deallocate(capacity: typeCount)
    }
}
