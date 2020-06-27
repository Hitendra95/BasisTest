//
//  UpdateViewProtocol.swift
//  BasisTest
//
//  Created by Hitendra Dubey  on 26/06/20.
//  Copyright © 2020 Hitendra Dubey . All rights reserved.
//

import Foundation

//MARK: Update view Protocl to listen respone and update views
protocol UpdateViewProtocol : NSObjectProtocol {
    func updateView(event: Int, eventtype: Int)
}
