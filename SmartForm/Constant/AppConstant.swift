//
//  AppConstant.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 14/02/21.
//

import Foundation
import UIKit

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case iPhone
    case iPad
}

public typealias JSONDictionary = [String: Any]

// Line capability for labels
let numberOfLinesCapability = 0
// Image Dimesion for profile imageview
let imageDimesion = 70
let CircledImage = imageDimesion/2

//MARK:- AppFonts
struct AppFonts {
    
    static func appTitleFont() -> UIFont {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UIFont.boldSystemFont(ofSize: 16)
        }else{
            return UIFont.boldSystemFont(ofSize: 15)
        }
    }
    static func customFont(fontSize : CGFloat?) -> UIFont {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UIFont.boldSystemFont(ofSize: fontSize ?? 18)
        }else{
            return UIFont.boldSystemFont(ofSize: fontSize ?? 15 )
        }
    }
    
    static func headerFont() -> UIFont {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UIFont.boldSystemFont(ofSize: 22)
        }else{
            return UIFont.boldSystemFont(ofSize: 20)
        }
    }
    
    static func appSubTitleFont() -> UIFont {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UIFont.boldSystemFont(ofSize: 18)
        }else{
            return UIFont.boldSystemFont(ofSize: 12)
        }
    }
}

//MARK:- Color Constant
struct AppColor {
    
    private struct Alphas {
        static let Opaque = CGFloat(1)
        static let SemiOpaque = CGFloat(0.6)
    }
    
    static let appThemeColor =  UIColor(red: 221/255, green: 244/255, blue: 238/255, alpha: Alphas.Opaque)
    static let appBackgroundWhiteColor =  UIColor.white
    
    //Title and SubTitle Color
    struct TextColors {
        static let title = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: Alphas.Opaque)
        static let subTitle = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: Alphas.SemiOpaque)
    }
    
    struct NavigationColors{
        static let  navigationBarColors = appThemeColor
        static let navigationBarTitleColors = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: Alphas.Opaque)
    }
    
    
}

