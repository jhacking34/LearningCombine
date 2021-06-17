//
//  NetError.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/17/21.
//

import Foundation

enum NetError: Error {
    case unkown
    case clientError
    case serverError
    case decodeError 
}
