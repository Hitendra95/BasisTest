//
//  ListParseModel.swift
//  BasisTest
//
//  Created by Hitendra Dubey  on 26/06/20.
//  Copyright © 2020 Hitendra Dubey . All rights reserved.
//

import Foundation

class ListParseModel{
    
    var list = ListModel()

    func parseUser(data: Data)-> ListModel{
        print("data to parse:\(data)")
        let decoder = JSONDecoder()
        do
        {
            list = try decoder.decode(ListModel.self, from: data)
            return list
        }
        catch
        {
            print(error.localizedDescription)
            return list
        }
    }
}
