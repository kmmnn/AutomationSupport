//
//  UIApplication+AutomationSupport.swift
//  CarDayAdminorIOS
//
//  Created by oliver.zhai on 2018/5/21.
//  Copyright © 2018年 HaiYang. All rights reserved.
//

import UIKit

extension UIApplication {
    private static let runOnce:Void = {
        AutomationSupportScaner.scan()
    }()
    
    open override var next: UIResponder?{
        UIApplication.runOnce
        return super.next
    }
}
