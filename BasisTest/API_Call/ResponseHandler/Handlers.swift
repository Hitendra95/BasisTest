//
//  Handlers.swift
//  Cricuru
//
//  Created by Hitendra Dubey on 22/04/20.
//  Copyright © 2020 Upasana sharma . All rights reserved.
//

import Foundation
import FirebaseAnalytics

class Handler{
    
    static let handlerSharedInstance = Handler()
    func getHandlers(eventType: Int,eventName: String) -> AppHandler
    {

        let handler = EventHanlders(type: eventType,name: eventName)
        return handler
    }
}

class EventHanlders: AppHandler
{
    let eventId : Int!
    let eventName: String!
    init(type: Int,name: String)
    {
        self.eventId = type
        self.eventName = name
    }
    func handleMessage(data: Data){//(data: Dictionary<String,AnyObject>) {
        print("response::\(data)")
        print("type: \(String(describing: eventId))")
        switch eventId {
        case NetworkEvents.EVENT_LOG_IN,NetworkEvents.EVENT_SIGN_UP,NetworkEvents.EVENT_SOCIAL_LOGIN:
           ModelFacade.sharedInstanceModelFacade.getAuthModel().parseUser(data: data)
        case NetworkEvents.EVENT_USER_DETAILS:
           ModelFacade.sharedInstanceModelFacade.getProfileModel().parseUser(data: data)
        case NetworkEvents.CHANGE_PASSWORD:
            ModelFacade.sharedInstanceModelFacade.getChangePasswordModel().parseUser(data: data)
            
        default:
            print("test")
        }
        Analytics.logEvent(eventName, parameters:
        [
            "api_status" :ConnectionModel.EVENT_TYPE_SUCCESS ,
            "response": data
        ])
        BaseModel.sharedInstanceBaseModel.notifyView(event: eventId, eventtype: ConnectionModel.EVENT_TYPE_SUCCESS)
    }
    func handleMessage(data: Array<AnyObject>) {
        print("response::\(data)")
        Analytics.logEvent(eventName, parameters:
        [
            "api_status" :ConnectionModel.EVENT_TYPE_SUCCESS ,
            "response": data
        ])
        BaseModel.sharedInstanceBaseModel.notifyView(event: eventId, eventtype: ConnectionModel.EVENT_TYPE_SUCCESS)
    }
    func handleServerError(data: Dictionary<String,AnyObject>) {
        print("error::\(data)")
        Analytics.logEvent(eventName, parameters:
        [
            "api_status" :ConnectionModel.EVENT_TYPE_ERROR ,
            "response": data
        ])
        BaseModel.sharedInstanceBaseModel.notifyView(event: eventId, eventtype: ConnectionModel.EVENT_TYPE_ERROR)
        }
    func handleParseError(data: String) {
        print("parse error::\(data)")
        Analytics.logEvent(eventName, parameters:
        [
            "api_status" :ConnectionModel.EVENT_TYPE_ERROR ,
            "response": data
        ])
        ModelFacade.sharedInstanceModelFacade.getConnectionModel().errorMessage = data
        BaseModel.sharedInstanceBaseModel.notifyView(event: eventId, eventtype: ConnectionModel.EVENT_TYPE_ERROR)
    }
    func handleNetworkError() {
        print("network error")
        Analytics.logEvent(eventName, parameters:
        [
            "api_status" :ConnectionModel.EVENT_TYPE_NETWORKERROR ,
            "response": "network error"
        ])
        BaseModel.sharedInstanceBaseModel.notifyView(event: eventId, eventtype: ConnectionModel.EVENT_TYPE_NETWORKERROR)
    }
}
