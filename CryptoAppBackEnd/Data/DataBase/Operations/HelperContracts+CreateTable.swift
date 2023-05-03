//
//  HelperContracts+CreateTable.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 03/05/23.
//

import Foundation



extension DBHelper {
    
 

    func createTable(tableName: String, properties: [(label: String, datatypes: String)],constraints : [Keys] = [] ,onSuccess: @escaping (String?) -> Void, onFailure: @escaping (Error?) -> Void) {
        
        let columnDefs = properties.map { "\($0.label) \($0.datatypes)" }
        let columnDefsStr = columnDefs.joined(separator: ", ")
        var createTableQuery = "CREATE TABLE IF NOT EXISTS \(tableName) (\(columnDefsStr),"
        
        
        if !constraints.isEmpty{
            for constraint in constraints {
                switch constraint {
                case .primary(let columnName):
                    // Add primary key constraint to SQL query
                    createTableQuery += " PRIMARY KEY (\(columnName))"
                    
                case .foreign(let columnName, let references):
                    // Add foreign key constraint to SQL query
                    let referencedTable = references.Table
                    let referencedColumn = references.column
                    
                    createTableQuery += " FOREIGN KEY (\(columnName)) REFERENCES \(referencedTable) (\(referencedColumn))"
                }
            }
        }
        

        createTableQuery += ");"

        print(createTableQuery)
        
        if true {
            onSuccess(createTableQuery)
        }else{
            onFailure(NSError(
                domain: "com.crypto",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Error: check for constraints"])
            )
        }
        
    }
}
