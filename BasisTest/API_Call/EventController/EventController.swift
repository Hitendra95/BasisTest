//
//  EventController.swift
//  BasisTest
//
//  Created by Hitendra Dubey  on 26/06/20.
//  Copyright © 2020 Hitendra Dubey . All rights reserved.
//

import Foundation

class EventsController{
    
    static let sharedInstanceAppController = EventsController()
    
    private init(){
        
    }
    
    //MARK: handler of particular event
    func handleEvent(eventid : Int) {
        switch eventid {
        case NetworkEvents.EVENT_GET_LIST:
            ModelFacade.sharedInstanceModelFacade.getAuthHits().GetList(handler: AuthResponseHandler.sharedInstanceResponseHandler.getListHandler())
        default:
            print("INSIDE DEFAULT EVENT")
        }
    }
    
}
