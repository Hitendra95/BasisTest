//
//  ModelFacade.swift
//  BasisTest
//
//  Created by Hitendra Dubey  on 26/06/20.
//  Copyright © 2020 Hitendra Dubey . All rights reserved.
//

import Foundation

class ModelFacade{
    static let sharedInstanceModelFacade = ModelFacade()
    
    private let authHits:AuthHits
    private let connectionModel:ConnectionModel
    private let list : ListParseModel

   
    private init(){
        authHits = AuthHits()
        list = ListParseModel()
        connectionModel = ConnectionModel()
       
    }
    
    func getConnectionModel()->ConnectionModel{
        return connectionModel
    }
    
    func getAuthHits()->AuthHits{
           return authHits
    }
    
    func getListModel()->ListParseModel
    {
        return list
    }
    
}
