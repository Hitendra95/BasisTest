//
//  ListModel.swift
//  BasisTest
//
//  Created by Hitendra Dubey  on 26/06/20.
//  Copyright © 2020 Hitendra Dubey . All rights reserved.
//

import Foundation

//MAKR: Codeable model of list
struct ListModel: Codable {
    var data: [ListData]?
}

struct ListData: Codable {
    var id, text: String?
}
