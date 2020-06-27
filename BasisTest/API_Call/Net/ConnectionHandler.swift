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
    
    //MARK: Check if net is connected
    func isConnectedToNetwork() -> Bool {
            
        var isReachable = false
        do
        {
           let reachability = try Reachability()
           if reachability.connection == .wifi || reachability.connection == .cellular{
               print("Reachable via WiFi or cellular")
               isReachable = true
           }
        }
        catch
        {
            
        }
        return isReachable
    }
    
    //MARK: MAke API call
    func makeHttpRequest(url: String, reqtype: HTTPMethod,handler:AppHandler, retrycount:Int){
        if retrycount > 0{
            AF.request(url, method: reqtype).responseString {
                response in
                switch response.result {
                //Handle success
                case .success:
                    var data = response.value ?? ""
                    data.remove(at: data.startIndex)
                    print(data)
                    if let resultDict = self.convertStringToDict(string: data){
                    if let statusCode = resultDict[Constants.KEY_STATUS_CODE] {
                        let statuscode = statusCode as! Int
                        if statuscode == 400 || statuscode == 404{
                            handler.handleServerError(data: resultDict)
                        }else{
                            handler.handleMessage(data: response.data!)
                        }
                    }else{
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: resultDict, options: .prettyPrinted)
                            // here "jsonData" is the dictionary encoded in JSON data
                            handler.handleMessage(data: jsonData)
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                    }
                    }
                    break
                 //handle failure
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
    
    //MARK: Convert json string to dictionary
    private func convertStringToDict(string: String) -> Dictionary<String,AnyObject>?
    {
        let data = string.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,AnyObject>
            {
               return jsonArray // use the json here
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
}

