//
//  ErrorForAlert.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/16/21.
//

import Foundation
import SwiftUI

struct ErrorForAlert: Error, Identifiable{
    let id = UUID()
    let title : Text
    var message : Text
}

struct AlertContext {
    static let unkown      = ErrorForAlert(title: Text("Unkown Error"),
                                           message: Text("Response wasn't recognized"))
    static let clientError = ErrorForAlert(title: Text("Client Error"),
                                           message: Text("Problem getting the information"))
    static let serverError = ErrorForAlert(title: Text("Server Error"),
                                           message: Text("Problem with the server"))
    static let decodeError = ErrorForAlert(title: Text("decodeError"),
                                           message: Text("Problem reading the returned data"))
    static let sucessful   = ErrorForAlert(title: Text("Sucessful"),
                                           message: Text("Upload of data was sucessful!"))
}
