//
//  HelperContract+Select.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 03/05/23.
//


import Foundation
import SQLite3

extension HelperContracts {
    func select(
        _ columns: [String],
        from tableName: String,
        where conditions: String? = nil,
        orderBy order: String? = nil,
        limit: Int? = nil,
        join tables: String? = nil,
        onSuccess: @escaping ([[String: Any]]?) -> Void,
        onFailure: @escaping (Error?) -> Void
    ) {
        var query = "SELECT \(columns.joined(separator:",")) FROM \(tableName)"
        
        if let conditions {
            query.append(" WHERE \(conditions)")
        }
        
        if let order {
            query.append(" ORDER BY \(order)")
        }
        
        if let limit {
            query.append(" LIMIT \(limit)")
        }
        // join
        if let tables {
            query.append(tables)
        }
        print(query)
        guard prepareQuery(query: query) != nil else {
            let error = String(cString: sqlite3_errmsg(dbPointer)).capitalized
            
            onFailure(
                NSError(
                    domain: "com.zohocorp",
                    code: 0,
                    userInfo: [NSLocalizedDescriptionKey: "Error: \(error)"])
            )
            return
        }
        
        defer {
            sqlite3_finalize(statementPointer)
        }
        
        /// Holds the results from the database. Array of Dictionary. DBrow is an alias for [String: Any]
        var results = [[String:Any]]()
        /// Execute one step using the compiled query
        var statusStep = sqlite3_step(statementPointer)
        while statusStep == SQLITE_ROW {
            /// Checks if Query returned any row
            if sqlite3_column_count(statementPointer) <= 0 {
                let error = String(cString: sqlite3_errmsg(dbPointer)).capitalized
                
                onFailure(
                    NSError(
                        domain: "com.zohocorp",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey: "Error: \(error)"])
                )
                
            }
            /// Variable to hold each row data
            var row = [String:Any]()
            for i in 0..<sqlite3_column_count(statementPointer) {
                /// Get each column Names
                let columnName = String(cString: sqlite3_column_name(statementPointer, i))
                /// Get type of the column
                let type = sqlite3_column_type(statementPointer, i)
                
                switch type {
                case SQLITE_INTEGER:
                    let value = sqlite3_column_int(statementPointer, i)
                    row[columnName] = value
                    
                case SQLITE_FLOAT:
                    let value = sqlite3_column_double(statementPointer, i)
                    row[columnName] = value
                    
                case SQLITE_TEXT:
                    let cString = sqlite3_column_text(statementPointer, i)
                    let value = String(cString: cString!)
                    row[columnName] = value
                    
                case SQLITE_NULL:
                    row[columnName] = nil
                    
                default:
                    // Handle unknown data type
                    onFailure(
                        NSError(
                            domain: "com.zohocorp",
                            code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Error: Undefined Datatype!"])
                    )
                    return
                }
            }
            /// Appending each row to the results
            results.append(row)
            /// Next Step  /  Next Row
            statusStep = sqlite3_step(statementPointer)
        }
        onSuccess(results)
    }
}
