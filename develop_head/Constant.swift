//
//  Constants.swift
//  devhead
//
//  Created by junlongnew on 2019/6/5.
//  Copyright © 2019 junlongnew. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

let APP_KEY = "u1ntgkc99st7sdhqjo5p"
let SHA_SALT = "u1ntgkc99st7sdhqjo5plhx8u92jg0ukjq4ap2du66jnlzaz3vobebz3x1qj"//sha1 slat

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
//(414,916) @3x  1242 x 2688px   xs max
//(375,812) @3x  1125 x 2436px   xs
//(414,896) @2x  828 x 1792px    xr
//(375,812) @3x  1125 x 2436px    x
//(414,736) @2x  1242 x 2208px iPhone 8p,7p,6sp,6p
//(375,667) @2x  750 x 1334px iPhone 8,7,6s,6
//(320,568) @2x  640 x 1136px iPhone SE,5,5S,5C
//(320,480) @2x  640 x 960px iPhone 4,4s

let IS_FACE_SCREEN:Bool = SCREEN_HEIGHT>=800
//49
let TAB_BAR_HEIGHT:CGFloat = IS_FACE_SCREEN ? 49 : 83

let FOOT_VIEW_COLOR = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

let TITLE_BAR_HEIGHT:CGFloat = 30

func FIT_HEIGHT(_ height:CGFloat)->CGFloat{
    return SCREEN_HEIGHT*height/667
}

extension String{
    var sha1:String{
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        let newData = NSData.init(data: data)
        CC_SHA1(newData.bytes, CC_LONG(data.count), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output as String
    }
}

extension UIColor{
    
    static func hex(_ hex:String, alpha:CGFloat = 1) -> UIColor{
        let h = Int(hex)
        guard let c = h else {
            return UIColor.black
        }
        let r = CGFloat((c & 0xff0000) >> 16) / 255
        let g = CGFloat((c & 0xff00) >> 8) / 255
        let b = CGFloat(c & 0xff) / 255
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    static func rgba(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat = 1) -> UIColor{
        
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}


protocol NibLoadable {}
extension NibLoadable where Self : UIView {
    static func loadFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
    }
}


typealias Callback<T> = (_ result:T)->Void
