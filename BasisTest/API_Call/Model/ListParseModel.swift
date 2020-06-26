//
//  UserModal.swift
//  BasisTest
//
//  Created by Hitendra Dubey  on 26/06/20.
//  Copyright © 2020 Hitendra Dubey . All rights reserved.
//

import Foundation

class ListParseModel{
    
    var list = List()

    func parseUser(data: Data)-> UserInfoModal{
        let decoder = JSONDecoder()
        do
        {
            list = try decoder.decode(List.self, from: data)
            return list
        }
        catch
        {
            return list
        }
    }
}
