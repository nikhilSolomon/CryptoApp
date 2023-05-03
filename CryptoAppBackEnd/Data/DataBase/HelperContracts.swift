//
//  HelperContracts.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 03/05/23.
//

import Foundation


enum Keys {
    case primary(columnName:String)
    case foreign(columnName:String,references:(Table:String,column:String))
}

protocol HelperContracts {
    
    var dbPointer : OpaquePointer? {get set}
    
    var statmentPointer : OpaquePointer? {get set}
    
    func open(_ pathToDatabase : String)
    
    func close()
    
    func prepareQuery(query: String) -> Int32?

    func errorMessage(db:OpaquePointer?)-> String

    func createTable(tableName: String,
                     properties: [(label: String, datatypes: String)],
                     constraints : [Keys],
                     onSuccess: @escaping (String?) -> Void,
                     onFailure: @escaping (Error?) -> Void)
    }
    
    

