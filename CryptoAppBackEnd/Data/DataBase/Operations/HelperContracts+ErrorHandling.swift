//
//  DBErrorHandling.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 03/05/23.
//

import Foundation
import SQLite3

enum SQLiteError: Error {
  case OpenDb(message: String)
  case Preparestmt(message: String)
  case Step(message: String)
  case Bind(message: String)
  case databaseError
}

extension HelperContracts{
    
    func errorMessage(db:OpaquePointer?)-> String {
        if let errorPointer = sqlite3_errmsg(db) {
            let errorMessage = String(cString: errorPointer)
            return errorMessage
        } else{
            return "No error message provided from sqlite."
        }
    }
}

