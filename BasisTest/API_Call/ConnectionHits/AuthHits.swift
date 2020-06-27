//
//  AuthHits.swift
//  BasisTest
//
//  Created by Hitendra Dubey  on 26/06/20.
//  Copyright © 2020 Hitendra Dubey . All rights reserved.
//

import Foundation
import Alamofire

//MARK: Make api call and pass the handler of that api call
class AuthHits{
    func GetList(handler:AppHandler)
    {
        let conn : ConnectionHandler = ConnectionHandler()
        if conn.isConnectedToNetwork(){
            
            conn.makeHttpRequest(url: URls.List_Fetch_Path, reqtype: .get, handler: handler, retrycount: Constants.MAX_RETRY_LIMIT)
        }else{
            handler.handleNetworkError()
        }
    }
}
