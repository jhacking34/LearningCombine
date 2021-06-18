//
//  UrlResponseErrors.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/16/21.
//

import Foundation

enum UrlResponseErrors: String, Error {
    case unkown = "Response wasn't recognized"
    case clientError = "Problem getting the information"
    case serverError = "Problem with the server"
    case decodeError = "Problem reading the returned data"
}
