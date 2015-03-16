//
//  Constans.swift
//  SocialWatch
//
//  Created by Francisco Caro Diaz on 09/03/15.
//  Copyright (c) 2015 AreQua. All rights reserved.
//

import Foundation

// ViewController

let VC_HOME = "Home"
let VC_LOGIN = "Login"
let VC_MAIN = "Main"
let VC_REGISTER = "Registro"
let VC_TUTORIAL = "Login"

// NSUserDefault
let kUSER = "user"
let kLOGIN = "Login"
let kTUTORIAL = "tutorial"
let kUSER_LOGIN_DEFAULT = "login_default"
let kUSER_LOGIN_FACEBOOK = "login_facebook"
let kUSER_LOGIN_GOOGLE = "login_google"

// Request Parameter
let REQUEST_LOGIN = "login"
let REQUEST_REGISTER = "register"
let REQUEST_GET_USER = "get"
let REQUEST_BRAND_LIST = "list"

// Request Params
let PARAM_USERID = "userId"

// Default User
let kUSER_USERID = "user_userID"
let kUSER_NICKNAME = "user_nickName"
let kUSER_EMAIL = "user_email"
let kUSER_GENDER = "user_gender"
let kUSER_PICTURE = "user_picture"

// Fb User
let kUSER_FB_USERID = "user_fb_userID"
let kUSER_FB_NICKNAME = "user_fb_nickName"
let kUSER_FB_EMAIL = "user_fb_email"
let kUSER_FB_GENDER = "user_fb_gender"
let kUSER_FB_PICTURE = "user_fb_picture"

// G+ User
let kUSER_G_USERID = "user_g_userID"
let kUSER_G_NICKNAME = "user_g_nickName"
let kUSER_G_EMAIL = "user_g_email"
let kUSER_G_GENDER = "user_g_gender"
let kUSER_G_PICTURE = "user_g_picture"


let USER_DEFAULT = 0
let USER_FACEBOOK = 1
let USER_GOOGLE = 3

// WebService : Response
let WS_RESPONSE_ELEMENT_DATA = "data"
let WS_RESPONSE_ELEMENT_RESULT = "result"
let WS_RESPONSE_ELEMENT_RESULT_STATUS = "status"
let WS_RESPONSE_ELEMENT_RESULT_MESSAGE = "msg"
let WS_RESPONSE_STATUS_OK = "ok"
let WS_RESPONSE_STATUS_KO = "fail"
let WS_RESPONSE_STATUS_KO_MSG_1 = "A user already exists with this nickname."
let WS_RESPONSE_STATUS_KO_MSG_2 = "A user already exists with this email."

// Google +
let GOOGLE_CLIENT_ID = "XXXXXX"

// Notifications
let NOTIFICATION_FACEBOOK_LOGIN = "PostDataFBUSer"
let NOTIFICATION_USER_DATA_RECEIVE = "PostDataUserReceiveFromServer"
let NOTIFICATION_VIEW_TUTORIAL = "ViewTutorial"

// Variables globales
var TYPE_REGISTER_RRSS : Int!
var USER_DATA : User!


