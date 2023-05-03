//
//  DBHandler.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 03/05/23.
//

import Foundation
import SQLite3

class DBHelper : HelperContracts{
    
    var statementPointer: OpaquePointer?
    
    
    var dbPointer: OpaquePointer?
    
    
    deinit{close()}
    
    func open(_ pathToDatabase: String) {
        
        if sqlite3_open(FileHandler.shared.open(path: pathToDatabase), &dbPointer) != SQLITE_OK {
            print("Error establishing connection to the database.")
        }
    }
    
    func close() {
        sqlite3_close(dbPointer)
    }
    
    func prepareQuery(query: String) -> Int32? {
        
        let preparedStatement = sqlite3_prepare_v2(dbPointer, query, -1, &statementPointer, nil)
        
        if preparedStatement == SQLITE_OK {
            return preparedStatement
        }else{
            return nil
        }
    }
    
    
   
    
    
}
