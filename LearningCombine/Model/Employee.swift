//
//  Employee.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/14/21.
//

import Foundation

struct Employee: Codable, Identifiable{
    let id : UUID
    let empID : Int
    let fname : String
    let lname : String
    let email : String
    let imageURL : String?
}

struct EmployeeResponse: Decodable{
    let response : [Employee]
}
