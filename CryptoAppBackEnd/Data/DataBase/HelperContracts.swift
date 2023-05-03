//
//  HelperContracts.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 03/05/23.
//

import Foundation




protocol HelperContracts {
    
    var dbPointer : OpaquePointer? {get set}
    
    var statementPointer : OpaquePointer? {get set}
    
    func open(_ pathToDatabase : String)
    
    func close()
    
    func prepareQuery(query: String) -> Int32?

    func errorMessage(db:OpaquePointer?)-> String

    func createTable(tableName: String,
                     properties: [(label: String, datatypes: String)],
                     constraints: [Keys],
                     onSuccess: @escaping (String?) -> Void,
                     onFailure: @escaping (Error?) -> Void)
    
    func insertData(tableName: String,
                    columns: [String]?,
                    values: [Any],
                    onSuccess: @escaping (String?) -> Void,
                    onFailure: @escaping (Error?) -> Void)
    
    
    func select(
        _ columns: [String],
        from tableName: String,
        where conditions: String?,
        orderBy order: String?,
        limit: Int?,
        join tables: String?,
        onSuccess: @escaping ([[String: Any]]?) -> Void,
        onFailure: @escaping (Error?) -> Void
        
        
    )
    
    }
    
    

