//
//  ConnectionHandler.swift
//  BasisTest
//
//  Created by Hitendra Dubey  on 26/06/20.
//  Copyright © 2020 Hitendra Dubey . All rights reserved.
//
import Foundation
import Alamofire
import Reachability


class ConnectionHandler{
    
    var errorMessage : String = ""
    
    func isConnectedToNetwork() -> Bool {
            
        var isReachable = false
        let reachability = Reachability()
        if reachability.isReachable(){
            print("Reachable via WiFi or cellular")
            isReachable = true
        }
        return isReachable
    }
    
    func makeHttpRequest(url: String, reqtype: HTTPMethod,handler:AppHandler, retrycount:Int){
        if retrycount > 0{
            AF.request(url, method: reqtype) .responseJSON {
                response in
                print(response)
                switch response.result {
                case .success:
                    if let resultDict = response.value as? Dictionary<String,AnyObject>{
                    if let statusCode = resultDict[Constants.KEY_STATUS_CODE] {
                        let statuscode = statusCode as! Int
                        if statuscode == 400 || statuscode == 404{
                            handler.handleServerError(data: resultDict)
                        }else{
                            handler.handleMessage(data: response.data!)
                        }
                    }else{
                        handler.handleMessage(data: response.data!)
                    }
                    }else if let resultDict = response.value as? Array<AnyObject>{
                        handler.handleMessage(data: resultDict)
                    }
                    break
                case .failure(let error):
                    print(error)
                    self.errorMessage = error.localizedDescription
                    if self.errorMessage == Constants.ERROR_TIMEOUT{
                        handler.handleParseError(data: error.localizedDescription)
                    }else{
                        let count = retrycount - 1
                        self.makeHttpRequest(url: url, reqtype: reqtype, handler:handler, retrycount:count)
                    }
                }
            }
        }else{
            handler.handleParseError(data: errorMessage)
        }
    }
    
}

