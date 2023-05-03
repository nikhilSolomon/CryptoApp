//
//  AppDelegate.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 02/05/23.
//

import Cocoa


class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create a CryptoWallet object for the user's wallet
        DBHelper().open("CryptoAppTest.db")
        
        let asb = [("id","TEXT"),("userName","TEXT"),("password","TEXT"),("FavoritesCoinList","TEXT"),("lastLoggedIn","DATETIME"),("dataOfJoining","DATATIME")]

        DBHelper().createTable(tableName: "Users", properties: asb,constraints: [Keys.primary(columnName: "id"),Keys.foreign(columnName: "id", references: (Table: "users", column: "userid"))],
        onSuccess: { _ in
            print("createa successfully")
            
        }, onFailure: {
            _ in
            print("cant Create table")
        })

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

