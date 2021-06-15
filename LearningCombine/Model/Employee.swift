//
//  Employee.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/14/21.
//

import Foundation

struct Employee: Decodable{
    let id : String
//    let empID : Int
    let fname : String
    let lname : String
    let email : String
    let imageURL : String
}

struct EmployeeResponse: Decodable{
    let resource : [Employee]
}
