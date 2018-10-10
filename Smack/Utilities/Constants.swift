//
//  LeagueVC.swift
//  Smack
//
//  Created by Mac on 7/19/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation

typealias CompletionHandeler = (_ Success: Bool) -> ()

//URL Constants
let BASE_URL = "https://tinaschattychatchat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"

//Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5)
//Notification constant
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("NotifUserDataChanged")
let NOTIF_CHANNALS_LOADED = Notification.Name("ChannelsLoaded")
let NOTIF_CHANNAL_SELECTED = Notification.Name("ChannelSelected")


// segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"


//Users defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


//Headers
let HEADER =  [
    "Content-Type": "application/json; charset=utf-8 "
]
let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8 "
    
]
