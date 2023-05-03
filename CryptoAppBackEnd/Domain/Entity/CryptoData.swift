//
//  CryptoData.swift
//  CryptoApp
//
//  Created by nikhil-pt6881 on 02/05/23.
//

import Foundation
// naming 
struct CryptoData {
    var id, symbol, name: String?
    var image: String?
    var currentPrice, marketCap, marketCapRank, fullyDilutedValuation: Int?
    var totalVolume, high24H, low24H: Int?
    var priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    var circulatingSupply, totalSupply, maxSupply, ath: Int?
    var athChangePercentage: Double?
    var athDate: String?
    var atl, atlChangePercentage: Double?
    var atlDate: String?
    var roi: NSNull?
    var lastUpdated: String?
    var sparklineIn7D: SparklineIn7D?
    var priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage30DInCurrency, priceChangePercentage7DInCurrency: Double?
}

// MARK: - SparklineIn7D

struct SparklineIn7D {
    var price: [Double]?
}
