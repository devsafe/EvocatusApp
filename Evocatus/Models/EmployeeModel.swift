//
//  EmployeeModel.swift
//  ELegion-Hack
//
//  Created by Boris Sobolev on 02.10.2021.
//

import Foundation

struct EmployeeModel {
    var userName: String
    var password: String
    var name: String
    var surName: String
    var fullName: String {
        return name + " " + surName
    }
    var avatar: String
    var position: String
    var department: String
    var location: String
    var favPlaces: [Event
    ]
}
