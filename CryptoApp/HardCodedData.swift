//
//  HardCodedData.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 02/05/23.
//

import Foundation






var wallet = [ (CryptoWallet(coinId: "BTC", name: "Bitcoin", iconUrl: URL(string: "https://example.com/bitcoin.png")!, quantity: 1.23, priceAtPurchase: 50000.00)) , (CryptoWallet(coinId: "ETH", name: "Ethereum", iconUrl: URL(string: "https://example.com/etherreum.png")!, quantity: 10.23, priceAtPurchase: 4500.00))]
// Create a User object
let user1 = User( userName: "johndoe", password: "secretpassword", cryptoWallet: wallet, balance: 5000.00, favoriteCoinList: ["BTC", "ETH"], lastLoggedIn: Date(), dateOfJoining: Date(timeIntervalSinceNow: -86400))

// Create a User object

