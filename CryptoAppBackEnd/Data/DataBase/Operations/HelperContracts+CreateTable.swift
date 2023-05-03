//
//  HelperContracts+CreateTable.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 03/05/23.
//

import Foundation
import SQLite3

enum Keys {
    case primary(columnName:String)
    case foreign(columnName:String,references:(Table:String,column:String))
}

extension HelperContracts {
    
    func createTable(tableName: String, properties: [(label: String, datatypes: String)],constraints : [Keys] = [] ,onSuccess: @escaping (String?) -> Void, onFailure: @escaping (Error?) -> Void) {
        
        let columnDefs = properties.map { "\($0.label) \($0.datatypes)" }
        let columnDefsStr = columnDefs.joined(separator: ", ")
        var query = "CREATE TABLE IF NOT EXISTS \(tableName) (\(columnDefsStr),"
        
        
        if !constraints.isEmpty{
            for constraint in constraints {
                switch constraint {
                case .primary(let columnName):
                    // Add primary key constraint to SQL query
                    query += " PRIMARY KEY (\(columnName))"
                    
                case .foreign(let columnName, let references):
                    // Add foreign key constraint to SQL query
                    let referencedTable = references.Table
                    let referencedColumn = references.column
                    
                    query += " FOREIGN KEY (\(columnName)) REFERENCES \(referencedTable) (\(referencedColumn))"
                }
            }
        }
        
        
        query += ");"
        
        guard prepareQuery(query: query) != nil else {
            onFailure(
                NSError(
                    domain: "com.zohocorp",
                    code: 0,
                    userInfo: [NSLocalizedDescriptionKey: "Error: Table Creation Failed."])
            )
            return
        }
        
        defer {
            
            sqlite3_finalize(statementPointer)
        }
        
        if sqlite3_step(statementPointer) == SQLITE_DONE {
            onSuccess("Table has been Created.")
        } else {
            let error = String(cString: sqlite3_errmsg(dbPointer)).capitalized
            onFailure(
                NSError(
                    domain: "com.zohocorp",
                    code: 0,
                    userInfo: [NSLocalizedDescriptionKey: "Error: \(error)"])
            )
            return
        }
    }
    
}

