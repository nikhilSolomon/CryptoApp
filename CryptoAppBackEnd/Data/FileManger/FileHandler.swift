//
//  FileHandler.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 03/05/23.
//

import Foundation


class FileHandler {
    
    static let shared = FileHandler()
    
    private init() {}
    //  Gets the URL for the Documents directory in the app's sandbox on macOS. The returned URL points to the directory where the app can store user-generated data such as files or SQLite databases.
    func open(directory: FileManager.SearchPathDirectory = .documentDirectory,
              domain: FileManager.SearchPathDomainMask = .userDomainMask,
              path: String
    )-> String? {
        
        let file = try? FileManager.default.url(for: directory, in: domain,appropriateFor: nil,create: false).appending(path: path)
        
        if let file = file {
            print(file.path)
            return file.path
        }else
        {
            return nil
        }
    }
    
}
