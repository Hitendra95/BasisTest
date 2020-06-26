//
//  Constants.swift
//  Cricuru
//
//  Created by Upasana sharma  on 31/03/20.
//  Copyright © 2020 Upasana sharma . All rights reserved.
//

import Foundation
import UIKit
extension UIFont
{
    ///font declaration
    static let fontName = "Roboto"
    static let regular = "-Regular"
    static let medium = "-Medium"
    static let bold = "-Bold"
    //Normal font
    
    static let regularFont_10 = UIFont.init(name: fontName+regular, size: 10)!
    static let regularFont_12 = UIFont.init(name: fontName+regular, size: 12)!
    static let regularFont_13 = UIFont.init(name: fontName+regular, size: 13)!
    static let regularFont_14 = UIFont.init(name: fontName+regular, size: 14)!
    static let regularFont_15 = UIFont.init(name: fontName+regular, size: 15)!
    static let regularFont_16 = UIFont.init(name: fontName+regular, size: 16)!
    static let regularFont_17 = UIFont.init(name: fontName+regular, size: 17)!
    static let regularFont_18 = UIFont.init(name: fontName+regular, size: 18)!
    static let regularFont_19 = UIFont.init(name: fontName+regular, size: 19)!
    static let regularFont_20 = UIFont.init(name: fontName+regular, size: 20)!
    static let regularFont_24 = UIFont.init(name: fontName+regular, size: 24)!
    
    //Medium font
    static let mediumFont_10 = UIFont.init(name: fontName+medium, size: 10)!
    static let mediumFont_12 = UIFont.init(name: fontName+medium, size: 12)!
    static let mediumFont_13 = UIFont.init(name: fontName+medium, size: 13)!
    static let mediumFont_14 = UIFont.init(name: fontName+medium, size: 14)!
    static let mediumFont_15 = UIFont.init(name: fontName+medium, size: 15)!
    static let mediumFont_16 = UIFont.init(name: fontName+medium, size: 16)!
    static let mediumFont_17 = UIFont.init(name: fontName+medium, size: 17)!
    static let mediumFont_18 = UIFont.init(name: fontName+medium, size: 18)!
    static let mediumFont_19 = UIFont.init(name: fontName+medium, size: 19)!
    static let mediumFont_20 = UIFont.init(name: fontName+medium, size: 20)!
    static let mediumFont_24 = UIFont.init(name: fontName+medium, size: 24)!
    static let mediumFont_56 = UIFont.init(name: fontName+medium, size: 56)!
    static let mediumFont_30 = UIFont.init(name: fontName+medium, size: 30)!

    
    //Bold font
    static let boldFont_10 = UIFont.init(name: fontName+bold, size: 10)!
    static let boldFont_12 = UIFont.init(name: fontName+bold, size: 12)!
    static let boldFont_13 = UIFont.init(name: fontName+bold, size: 13)!
    static let boldFont_14 = UIFont.init(name: fontName+bold, size: 14)!
    static let boldFont_15 = UIFont.init(name: fontName+bold, size: 15)!
    static let boldFont_16 = UIFont.init(name: fontName+bold, size: 16)!
    static let boldFont_17 = UIFont.init(name: fontName+bold, size: 17)!
    static let boldFont_18 = UIFont.init(name: fontName+bold, size: 18)!
    static let boldFont_19 = UIFont.init(name: fontName+bold, size: 19)!
    static let boldFont_24 = UIFont.init(name: fontName+bold, size: 24)!
    
}

extension UIColor {

    @nonobjc class var BaseBlack: UIColor {
    return UIColor(red: 11.0 / 255.0 , green: 10.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var facebookBlue: UIColor {
    return UIColor(red: 23.0 / 255.0, green: 120.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var BaseWhite: UIColor {
    return UIColor(red: 240.0 / 255.0, green: 239.0 / 255.0 , blue: 244.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var NeutralGray: UIColor {
    return UIColor(red: 48.0 / 255.0, green: 51.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var LightGray: UIColor {
    return UIColor(red: 177.0 / 255.0, green: 181.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var DarkGray: UIColor {
    return UIColor(red: 127.0 / 255.0, green: 131.0 / 255.0, blue: 134.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var BrandColor: UIColor {
    return UIColor(red: 255.0 / 255.0, green: 220.0 / 255.0 , blue: 0.0, alpha: 1.0)
  }

  @nonobjc class var BrandGradient: UIColor {
    return UIColor(red: 255.0 / 255.0, green: 243.0 / 255.0, blue: 76.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var error: UIColor {
    return UIColor(red: 219.0 / 255.0, green: 22.0 / 255.0, blue: 47.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var success: UIColor {
    return UIColor(red: 65 / 255.0, green: 187.0 / 255.0, blue: 71 / 255.0, alpha: 1.0)
  }

}

class APIExtensionURL
{
    static let BASE_URL = "https://api.cricuru.com/api"
    static let LOGIN_URL = "/auth/login"
    static let SIGN_UP_URL = "/auth/signup"
    static let SOCIAL_LOGIN = "/auth/social"
    static let GET_USER = "/user"
    static let CHNAGE_PASSWORD = "/user/password/change"
}

class API_Headers
{
    static let JSON_CONTENT_TYPE = "Content-Type"
    static let TYPE_JSON = "application/json"
    static let AUTHORIZATION = "Authorization"
}

class Constants {
    
    // Common Variables
    static let USER_DEFAULT = UserDefaults.standard
    static let KEY_IS_LOGGEDIN = "isLoggedIn"
    static let MAX_RETRY_LIMIT : Int = 2
    static let DEVICE : String = "iphone"
    static var FONT_TITILLIUM : String = "TitilliumWeb-Regular"

    static let ERROR = "error"
    static let ERROR_TIMEOUT = "The request timed out."
    static let ERROR_NETWORK_ERROR = "Something went wrong. Please try again."
    static let JSON_DEVICE_TYPE_VALUE = "ios"
    static let IS_API_PUBLIC : Bool = false
    
    static let SQUARE_APPID : String = "sq0idp-pVf8yuiuP5sTBraePnwSng"
    static let SQUARE_ACCESSTOKEN : String = "sq0atp-jzFE4WNibmzBhGKGvdBDmQ"
    
    
    
    
    /// cricuru
    static let KEY_STATUS_CODE = "statusCode"
    static let KEY_EMAIL = "email"
    static let KEY_PASSWORD = "password"
    static let KEY_FULL_NAME = "fullName"
    static let KEY_TOKEN = "token"
    static let KEY_DOB = "dob"
    static let KEY_TYPE = "type"

   
    
    
    static let DATEFORMAT = "yyyy-MM-dd’T’HH:mm:ss.SSSZ"
    
    
    
    // Text Based Keys
    static let KEY_MESSAGE = "message"
    static let KEY_USER = "user"
    static let KEY_AUTH = "auth"
    static let KEY_USERID = "userid"
    static let KEY_DATA = "data"
    
    static let KEY_USER_NAME = "username"
    static let KEY_OLD_PASSWORD = "old_password"
    static let KEY_CONFIRM_PASSWORD = "confirm_password"
    static let KEY_JWT = "jwt"
    static let KEY_ID =  "_id"
    static let KEY_AUTH_TYPE = "authType"
    static let KEY_TEXT =  "text"
    static let KEY_ADDRESSES = "addresses"
    static let KEY_PHONE_NUMER = "phonenumber"
    static let KEY_PROVIDER = "provider"
    static let KEY_ROLE = "role"
    static let KEY_NAME = "name"
    static let KEY_CONFIRMED = "confirmed"
    static let KEY_BLOCKED = "blocked"
    static let KEY_VERSION = "__v"
    static let KEY_IDENTIFIER = "identifier"
    static let KEY_REQUEST_TYPE_SENT = "REQUEST_TYPE_SENT"
    
    static let KEY_OLDPASSWORD = "oldPassword"
    static let KEY_NEWPASSWORD = "newPassword"
   
    
    
    
    
  
    
}

