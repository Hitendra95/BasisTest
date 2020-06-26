//
//  UpdateViewProtocol.swift
//  Cricuru
//
//  Created by Upasana sharma  on 03/04/20.
//  Copyright © 2020 Upasana sharma . All rights reserved.
//

import Foundation

protocol UpdateViewProtocol : NSObjectProtocol {
    func assignDelegates()
    func applyFieldConstraints()
    func updateView(event: Int, eventtype: Int)
    func isEqual(object: AnyObject!) -> Bool
}
