//
//  ConnectionHandler.swift
//  Cricuru
//
//  Created by Upasana sharma  on 03/04/20.
//  Copyright © 2020 Upasana sharma . All rights reserved.
//
import Foundation
import Alamofire
import SystemConfiguration
import QorumLogs

class ConnectionHandler{
    
    var errorMessage : String = ""
    let helper = HelperFunctions.sharedInstance
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
    
    func makeHttpRequest(url: String, reqtype: HTTPMethod, data:Dictionary<String, AnyObject>, handler:AppHandler, retrycount:Int, isPublic: Bool){
        print("original dict::\(data)")
        print("url::\(url)")
        print("reqtype::\(reqtype)")
        print("isPublic::\(isPublic)")
        if retrycount > 0{
            var reqheaders : HTTPHeaders = [
                "Authorization": "",
                "Content-Type" : "application/json"
            ]

            reqheaders[API_Headers.JSON_CONTENT_TYPE] = API_Headers.TYPE_JSON
            if !isPublic{
                reqheaders[API_Headers.AUTHORIZATION] = "Bearer " + helper.returnToken()//ModelFacade.sharedInstanceModelFacade.getAuthModel().user.jwt!
            }
            var requestDict = Dictionary<String, AnyObject>()
            
            
            print("req headers dict::\(reqheaders)")
            
            if reqtype == .get{
                AF.request(url, method: reqtype, parameters: requestDict, encoding: URLEncoding.default, headers: reqheaders) .responseJSON {
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
                            self.makeHttpRequest(url: url, reqtype: reqtype, data:data, handler:handler, retrycount:count, isPublic: isPublic)
                        }
                    }
                }
            }else{
                requestDict = data
                print("sent dict::\(requestDict)")
                AF.request(url, method: reqtype, parameters: requestDict, encoding: JSONEncoding.default, headers: reqheaders).responseJSON {
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
                                    guard let data = response.data else {return}
                                    handler.handleMessage(data: data)
                                }
                            }else{
                                guard let data = response.data else {return}
                                handler.handleMessage(data: data)
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
                            self.makeHttpRequest(url: url, reqtype: reqtype, data:data, handler:handler, retrycount:count, isPublic: isPublic)
                        }
                    }
                }
            }
        }else{
            handler.handleParseError(data: errorMessage)
        }
    }
    
}

