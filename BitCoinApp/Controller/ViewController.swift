//
//  ViewController.swift
//  ByteCoin
//
//  Created by Ahmed Gaber on 7/7/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate{

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var bitcoinCurrency: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self	
        coinManager.delegate = self


        // Do any additional setup after loading the view.
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(currency: currency)
    }
    func didupdateBitcoin(rate: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = rate
            self.bitcoinCurrency.text = currency
            
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    

}





