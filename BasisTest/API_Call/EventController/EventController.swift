//
//  EventController.swift
//  Cricuru
//
//  Created by Upasana sharma  on 03/04/20.
//  Copyright © 2020 Upasana sharma . All rights reserved.
//

import Foundation
import QorumLogs

class EventsController{
    
    static let sharedInstanceAppController = EventsController()
    
    private init(){
        
    }
    
    func handleEvent(eventid : Int, data : Dictionary<String, AnyObject>!) {
        switch eventid {
        case NetworkEvents.EVENT_LOG_IN:
            ModelFacade.sharedInstanceModelFacade.getAuthHits().logIn(data: data, handler: AuthResponseHandler.sharedInstanceResponseHandler.getLogInHandler())
        case NetworkEvents.EVENT_SIGN_UP:
            ModelFacade.sharedInstanceModelFacade.getAuthHits().signUp(data: data, handler: AuthResponseHandler.sharedInstanceResponseHandler.signUPHandler())
        case NetworkEvents.EVENT_SOCIAL_LOGIN:
            ModelFacade.sharedInstanceModelFacade.getAuthHits().socialLoginSignUp(data: data, handler: AuthResponseHandler.sharedInstanceResponseHandler.socialLogInHandler())
        case NetworkEvents.EVENT_USER_DETAILS:
            ModelFacade.sharedInstanceModelFacade.getAuthHits().getUser(data: data, handler: ProfileResponseHandler.sharedInstanceResponseHandler.getUserDetailsHandler())
        case NetworkEvents.CHANGE_PASSWORD:
            ModelFacade.sharedInstanceModelFacade.getAuthHits().changePassword(data: data, handler: ProfileResponseHandler.sharedInstanceResponseHandler.changePasswordHandler())
        default:
            print("\\\\\\\\\\INSIDE DEFAULT HANDLE EVENT\\\\\\\\\\\\")
        }
    }
    
}
