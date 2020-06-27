//
//  AuthResponseHandler.swift
//  BasisTest
//
//  Created by Hitendra Dubey on 26/06/20.
//  Copyright © 2020 Hitendra Dubey. All rights reserved.
//

import Foundation

class AuthResponseHandler{
    
    static let sharedInstanceResponseHandler = AuthResponseHandler()
    let handler = Handler.handlerSharedInstance
    private init(){
        
    }
    
    //MARK: Get Handler of particlur API
    func getListHandler()->AppHandler{
        
        return handler.getHandlers(eventType: NetworkEvents.EVENT_GET_LIST,eventName: NetworkEventsName.EVENT_GET_LIST)

    }
}
