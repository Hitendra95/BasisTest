//
//  AuthHits.swift
//  Cricuru
//
//  Created by Upasana sharma  on 03/04/20.
//  Copyright © 2020 Upasana sharma . All rights reserved.
//

import Foundation
import Alamofire

class AuthHits{
    func logIn(data : Dictionary<String, AnyObject>!, handler:AppHandler)
    {
        let conn : ConnectionHandler = ConnectionHandler()
        if conn.isConnectedToNetwork(){
            
            conn.makeHttpRequest(url: APIExtensionURL.BASE_URL + APIExtensionURL.LOGIN_URL , reqtype: HTTPMethod.post, data: data, handler: handler, retrycount: Constants.MAX_RETRY_LIMIT, isPublic: true)
        }else{
            handler.handleNetworkError()
        }
    }
    func signUp(data : Dictionary<String, AnyObject>!, handler:AppHandler)
    {
        let conn : ConnectionHandler = ConnectionHandler()
        if conn.isConnectedToNetwork(){

            conn.makeHttpRequest(url: APIExtensionURL.BASE_URL + APIExtensionURL.SIGN_UP_URL, reqtype: HTTPMethod.post, data: data, handler: handler, retrycount: Constants.MAX_RETRY_LIMIT, isPublic: true)
        }else{
            handler.handleNetworkError()
        }
    }
    func socialLoginSignUp(data : Dictionary<String, AnyObject>!, handler:AppHandler)
    {
        let conn : ConnectionHandler = ConnectionHandler()
        if conn.isConnectedToNetwork(){

            conn.makeHttpRequest(url: APIExtensionURL.BASE_URL + APIExtensionURL.SOCIAL_LOGIN, reqtype: HTTPMethod.post, data: data, handler: handler, retrycount: Constants.MAX_RETRY_LIMIT, isPublic: true)
        }else{
            handler.handleNetworkError()
        }
    }
    
    func getUser(data : Dictionary<String, AnyObject>!, handler:AppHandler)
    {
        let conn : ConnectionHandler = ConnectionHandler()
        if conn.isConnectedToNetwork(){

            conn.makeHttpRequest(url: APIExtensionURL.BASE_URL + APIExtensionURL.GET_USER, reqtype: HTTPMethod.get, data: data, handler: handler, retrycount: Constants.MAX_RETRY_LIMIT, isPublic: true)
        }else{
            handler.handleNetworkError()
        }

    }
    
    func changePassword(data : Dictionary<String, AnyObject>!, handler:AppHandler)
    {
        let conn : ConnectionHandler = ConnectionHandler()
        if conn.isConnectedToNetwork(){

            conn.makeHttpRequest(url: APIExtensionURL.BASE_URL + APIExtensionURL.CHNAGE_PASSWORD, reqtype: HTTPMethod.patch, data: data, handler: handler, retrycount: Constants.MAX_RETRY_LIMIT, isPublic: true)
        }else{
            handler.handleNetworkError()
        }

    }


}
