//
//  ModelFacade.swift
//  Cricuru
//
//  Created by Upasana sharma  on 03/04/20.
//  Copyright © 2020 Upasana sharma . All rights reserved.
//

import Foundation
import Foundation

class ModelFacade{
    static let sharedInstanceModelFacade = ModelFacade()
    
    private let authHits:AuthHits
    
    private let connectionModel:ConnectionModel
    private let authModel:AuthParseModel
    private let profileModal:ProfileParseModel
    private let changePasswordModel:ChangePasswordParseModel

   
    private init(){
        authHits = AuthHits()
        authModel = AuthParseModel()
        connectionModel = ConnectionModel()
        profileModal = ProfileParseModel()
        changePasswordModel = ChangePasswordParseModel()
       
    }
    
    func clearAllModels(){
    }
    
    func getProfileModel()->ProfileParseModel
    {
        return profileModal
    }
    
    func getChangePasswordModel()->ChangePasswordParseModel
    {
        return changePasswordModel
    }
    
    func getAuthModel()->AuthParseModel{
        return authModel
    }
    func getConnectionModel()->ConnectionModel{
        return connectionModel
    }
    
    func getAuthHits()->AuthHits{
           return authHits
       }
    
    
       
    
    
}
