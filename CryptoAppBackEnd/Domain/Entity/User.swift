//
//  User.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 02/05/23.
//
import Foundation
import CryptoKit

class User {
    var id: String
    var userName: String
    var password: String
    var cryptoWallet: [CryptoWallet]
    var balance: Double
    var favoriteCoinList: [String]
    var lastLoggedIn: Date
    var dateOfJoining: Date
    
    init(userName: String, password: String, cryptoWallet: [CryptoWallet] = [], balance: Double = 10000, favoriteCoinList: [String] = [], lastLoggedIn: Date = Date(), dateOfJoining: Date = Date()) {
        self.userName = userName
        self.password = password
        self.cryptoWallet = cryptoWallet
        self.balance = balance
        self.favoriteCoinList = favoriteCoinList
        self.lastLoggedIn = lastLoggedIn
        self.dateOfJoining = dateOfJoining
        
        let inputData = Data((userName+password).utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashedString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
        self.id = hashedString
    }
    
    func loginSessionHistory() {
        // Update lastLoggedIn property with the current date and time
        self.lastLoggedIn = Date()
        print("User \(self.userName) logged in at \(self.lastLoggedIn)")
    }
}

