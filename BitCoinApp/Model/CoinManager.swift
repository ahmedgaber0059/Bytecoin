//
//  CoinManager.swift
//  BitCoinApp
//
//  Created by Ahmed Gaber on 7/7/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate {
    func didupdateBitcoin(rate: String, currency: String)
    func didFailWithError (error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice (currency: String){
        let bitcoinURL = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=D9EFF9D4-8438-43A2-B690-54DD55894EBF"
        if let url = URL(string: bitcoinURL){
            let session = URLSession(configuration: .default )
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    
                    let bitcoinPrice = self.parseJSON(data: safeData)
                    let bitcoinPriceString = String(format: "%.2f", bitcoinPrice)
                    print(bitcoinPriceString)
                    self.delegate?.didupdateBitcoin(rate: bitcoinPriceString, currency: currency)
                    
                }
            }
            task.resume()
        }
        
    }
    func parseJSON (data:Data) ->Double{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            return decodedData.rate
        }
        catch{
            self.delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
    
}
