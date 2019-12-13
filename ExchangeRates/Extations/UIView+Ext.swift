//
//  UIView+Ext.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 12.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import UIKit

extension UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
    
    class func viewWithDefaultNib() -> Self {
        return self.viewWithType()
    }
    
    class func defaultNib() -> UINib {
        return UINib(nibName: stringFromClass(self), bundle: nil)
    }
    
}

// MARK: - Private Methods

private extension UIView {
    
    class func viewWithType<T>() -> T {
        let nib = UINib(nibName: stringFromClass(self), bundle: nil)
        
        return nib.instantiate(withOwner: nil, options: nil).first as! T
    }
    
}

func stringFromClass(_ anyClass: AnyClass) -> String {
    return NSStringFromClass(anyClass).components(separatedBy: ".").last!
}
