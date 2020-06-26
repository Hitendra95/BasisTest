//
//  UpdateViewProtocol.swift
//  BasisTest
//
//  Created by Hitendra Dubey  on 26/06/20.
//  Copyright © 2020 Hitendra Dubey . All rights reserved.
//

import Foundation

protocol UpdateViewProtocol : NSObjectProtocol {
    func assignDelegates()
    func applyFieldConstraints()
    func updateView(event: Int, eventtype: Int)
    func isEqual(object: AnyObject!) -> Bool
}
