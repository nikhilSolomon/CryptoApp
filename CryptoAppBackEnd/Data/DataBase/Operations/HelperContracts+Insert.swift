//
//  HelperContracts+Insert.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 03/05/23.
//

import Foundation
import SQLite3

extension HelperContracts {
    
    func insertData(tableName: String,
                    columns: [String]? = nil,
                    values: [Any],
                    onSuccess: @escaping (String?) -> Void,
                    onFailure: @escaping (Error?) -> Void)
    {
        var query = "INSERT INTO \(tableName) "
        
        if let columns {
            query.append("(\(columns.joined(separator: ", ")))")
        }
        
        query.append(" VALUES (")
        
        let columnCount = columns?.count ?? values.count
        
        if columnCount != values.count {
            onFailure(
                NSError(
                domain: "com.zohocorp",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Error: Column count and value count do not match.",]
                )
            )
            return
        }
        

        for i in 0..<columnCount{
            let value = values[i]
            if let strValue = value as? String {
                // handling quoatation and semicolon
                if strValue.contains("'") {
                    query.append("\"\(strValue)\"")
                }else if strValue.contains(";") {
                    query.append("'\(strValue)'")
                }  else {
                    query.append("\'\(strValue)\'")
                }
            } else if let intValue = value as? Int {
                query.append("\(intValue)")
            } else if let doubleValue = value as? Double {
                query.append("\(doubleValue)")
            } else if let boolValue = value as? Bool {
                // handling boolean values by converting into 0s and 1s
                query.append("\(boolValue ? 1 : 0)")
            } else if let date = value as? Date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                query.append("'\(dateFormatter.string(from: date))'")
            }
            else{
                    onFailure(
                        NSError(
                        domain: "com.zohocorp",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey: "Error: un supported DataTypes",]
                        )
                    )
                }
            
            
            if i < columnCount - 1{
                query+=","
            }
        }
        
        query.append(")")
        
        print(query)
        guard prepareQuery(query: query) != nil else {
            let error = String(cString: sqlite3_errmsg(dbPointer)).capitalized
            onFailure(
                NSError(
                domain: "com.zohocorp",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Error: \(error)",]
                )
            )
            return
        }
        
        defer {
            sqlite3_finalize(statementPointer)
        }
        
        if sqlite3_step(statementPointer) == SQLITE_DONE {
            onSuccess("Data Inserted Successfully")
            return
        } else {
            let error = String(cString: sqlite3_errmsg(dbPointer)).capitalized
            onFailure(
                NSError(
                    domain: "com.zohocorp",
                    code: 0,
                    userInfo: [NSLocalizedDescriptionKey: "Error: \(error)",]
                )
            )
            return
        }
    }
}
