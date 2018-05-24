//
//  UIViewController+AutomationSupport.swift
//  CarDayAdminorIOS
//
//  Created by oliver.zhai on 2018/5/21.
//  Copyright © 2018年 HaiYang. All rights reserved.
//

import UIKit


extension UIViewController: AutomationSupportProtocol{
    public static func awake() {
        guard (Bundle.main.infoDictionary?["APP_BASE_URL"] as! String) != "uat.car-day.cn" else {
            return
        }
        let originalSelector = #selector(UIViewController.viewWillAppear(_:))
        let swizzleSelector = #selector(UIViewController.ms_viewWillAppear(animated:))
        
        let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzleSelector)
        
        let didAddMethod = class_addMethod(UIViewController.self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        if didAddMethod{
            class_replaceMethod(UIViewController.self, swizzleSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        }
        else{
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    func ms_viewWillAppear(animated: Bool) {
        self.ms_viewWillAppear(animated: animated)
        setAccessibilityLabelIfExist()
    }
    
    
    func setAccessibilityLabelIfExist(){
        let hMirror = Mirror(reflecting: self)
        let _ = hMirror.children.map { (name, value) -> Void in
            guard let view = value as? UIView else{
                return
            }
            view.accessibilityLabel = name ?? ""
        }
    }
}
