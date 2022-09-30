//
//  Color+UIViewExtenstion.swift
//  sinc
//
//  Created by mac on 02/02/21.
//

import Foundation
import UIKit

extension UIColor{
    
    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  alpha: alpha)
    }
    
    convenience init?(hexaRGBA: String) {
        var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }
    
    convenience init?(hexaARGB: String) {
        var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
    
    static let appDarkGreen = UIColor(red: 0.404, green: 0.769, blue: 0.682, alpha: 1)
        //UIColor(red: 0.008, green: 0.447, blue: 0.369, alpha: 1)
    static let appLightGreen = UIColor(red: 0.361, green: 0.769, blue: 0.353, alpha: 1)
//        UIColor(red: 0, green: 0.647, blue: 0.49, alpha: 1)
    static let borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.2)
    
    static let buttonFontColor = UIColor(red: 0.508, green: 0.508, blue: 0.508, alpha: 1)
    static let textfieldTxtColor = UIColor(red: 0.3098, green: 0.3098, blue: 0.3098, alpha: 1)
    static let tagViewBlueColor = UIColor(red: 0, green: 0.4470, blue: 0.8038, alpha: 1)
    static let tagViewRedColor = UIColor(red: 0.867, green: 0.231, blue: 0.365, alpha: 1)
    static let tagViewCyanColor = UIColor(red: 0.176, green: 0.745, blue: 0.698, alpha: 1)
    
    static let fontDarkColor1 = UIColor(red: 51/255, green: 51/255 , blue: 51/255, alpha: 1)
    static let btnbackgroundPink = UIColor(red: 221/255, green: 59/255 , blue: 93/255, alpha: 1)
    static let fontGrayColor2 = UIColor(red: 79/255, green: 79/255 , blue: 79/255, alpha: 1)
    static let fontGrayColor3 = UIColor(red: 130/255, green: 130/255 , blue: 130/255, alpha: 1)
    
    static let sepraterViewColor = UIColor(red: 224/255, green: 224/255 , blue: 224/255, alpha: 1)
    
    static let textViewBGColor = UIColor(red: 235/255, green: 235/255 , blue: 235/255, alpha: 1)
    
}
