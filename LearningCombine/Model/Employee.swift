//
//  Employee.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/14/21.
//

import Foundation

struct Employee: Decodable{
    let id : String
    let empID : Int
    let fname : String
    let lname : String
    let email : String
    let imageURL : String
    
    static let `default` =  Employee(id: "00000", empID: 2, fname: "defualt", lname: "User", email: "d@fault.com", imageURL: "imag")
}

struct EmployeeResponse: Decodable{
    let resource : [Employee]
    
    static let `default` = EmployeeResponse(resource: [Employee.default])
}
