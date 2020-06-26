//
//  AppHandler.swift
//  BasisTest
//
//  Created by Hitendra Dubey  on 26/06/20.
//  Copyright © 2020 Hitendra Dubey . All rights reserved.
//

import Foundation

protocol AppHandler {
    func handleMessage(data: Data)
    func handleMessage(data:Array<AnyObject>)
    func handleServerError(data:Dictionary<String,AnyObject>)
    func handleParseError(data:String)
    func handleNetworkError()
}
