//
//  AppHandler.swift
//  Cricuru
//
//  Created by Upasana sharma  on 03/04/20.
//  Copyright © 2020 Upasana sharma . All rights reserved.
//

import Foundation

protocol AppHandler {
    func handleMessage(data: Data)
    func handleMessage(data:Array<AnyObject>)
    func handleServerError(data:Dictionary<String,AnyObject>)
    func handleParseError(data:String)
    func handleNetworkError()
}
