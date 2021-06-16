//
//  ErrorForAlert.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/16/21.
//

import Foundation

struct ErrorForAlert: Error, Identifiable{
    let id = UUID()
    let title = "Error"
    var message = "Please try again later."
}
