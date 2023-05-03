//
//  AppDelegate.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 02/05/23.
//

import Cocoa


class AppDelegate: NSObject, NSApplicationDelegate {

//    CREATE TABLE CryptoWallets (
//        id
//        CoinId TEXT PRIMARY KEY,
//        name TEXT,
//        iconUrl TEXT,
//        quantity REAL,
//        priceAtPurchase REAL,
//        NOT NULL (name)
//        FOREIGN KEY (id) REFERENCES Users(id)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create a CryptoWallet object for the user's wallet
        let DBHelper =   DBHelper()
        DBHelper.open("CryptoAppTest.db")
        
        let usersTable = [("id","TEXT"),("userName","TEXT"),("password","TEXT"),("FavoritesCoinList","TEXT"),("lastLoggedIn","DATETIME"),("dataOfJoining","DATATIME")]
        
//
        DBHelper.createTable(tableName: "Users", properties: usersTable,constraints: [Keys.primary(columnName: "id")],
        onSuccess: { _ in
            print("createad successfully")

        }, onFailure: {
            _ in
            print("cant Create table")
        })

        DBHelper.insertData(tableName: "Users",columns: ["id","userName","password","FavoritesCoinList","lastLoggedIn","dataOfJoining"], values: ["12343","Nikhil","solo123","BTC;ETH;ATH"
,"2023-05-03 11:24:51 +0000","2023-05-03 11:24:51 +0000"]) { result in
           print(result!)
        } onFailure: { err in
            print("cant insert values")
        }


    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

