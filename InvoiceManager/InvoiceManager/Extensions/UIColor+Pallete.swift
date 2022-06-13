//
//  UIColor+Pallete.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 13/06/22.
//

import UIKit

extension UIColor {
    
    static var appBlueColor: UIColor {
        return UIColor(hexString: "#0097e6")
    }
    
    static var appRedColor: UIColor {
        return UIColor(hexString: "#c23616")
    }
    
    static var appBlackColor: UIColor {
        return UIColor(hexString: "#353b48")
    }
    
    static var appGreyColor: UIColor {
        return UIColor(hexString: "#718093")
    }
    
    static var appWhiteColor: UIColor {
        return UIColor(hexString: "#f5f6fa")
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
            
}
