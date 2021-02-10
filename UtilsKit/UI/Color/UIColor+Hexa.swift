//
//  UIColor+Hexa.swift
//  UtilsKit
//
//  Created by RGMC on 11/05/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /**
     Custom initializer to create a UIColor from a hexadecimal code.
     
     - parameter withHexString: Hexadecimal code (#....).
     */
    public convenience init?(withHexString  hexString: String) {
        if hexString.hasPrefix("#") {
            let hex = String(hexString.dropFirst())
            
            let scanner = Scanner(string: hex)
            scanner.scanLocation = 0
            
            var rgbValue: UInt64 = 0
            
            scanner.scanHexInt64(&rgbValue)
            
            let red: UInt64 = (rgbValue & 0xff0000) >> 16
            let green: UInt64 = (rgbValue & 0xff00) >> 8
            let blue: UInt64 = rgbValue & 0xff
            
            self.init(
                red: red / 255,
                green: green / 255,
                blue: blue / 255,
                alpha: 1
            )
        } else {
            return nil
        }
    }

    /**
     Custom initializer to get hexadecimal string code of current color
     - output : Hexadecimal code "#....".
     */
    public func toHexString() -> String {
            var r:CGFloat = 0
            var g:CGFloat = 0
            var b:CGFloat = 0
            var a:CGFloat = 0

            getRed(&r, green: &g, blue: &b, alpha: &a)

            let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

            return String(format:"#%06x", rgb)
    }
}
