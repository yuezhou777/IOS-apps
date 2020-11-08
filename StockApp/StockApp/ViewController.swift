//
//  ViewController.swift
//  StockApp
//
//  Created by yue zhou on 2020/11/4.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController {

    let apiKey = "b0bffad58905bc81ef0d2a26f12ba2b0"
    
    let apiURL = "https://financialmodelingprep.com/api/v3/profile/"
    
    @IBOutlet weak var txtStockName: UITextField!
    
    
    @IBOutlet weak var lblCEO: UILabel!
    
    
    @IBOutlet weak var lblStockPrice: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getStockPrice(_ sender: Any) {
        guard let stockName = txtStockName.text else { return }
        
        let url = "\(apiURL)\(stockName)?apikey=\(apiKey)"
        
        getInfo(stockURL: url, stockName: stockName)
    }
    
    func getInfo(stockURL : String!, stockName : String!) {
        SwiftSpinner.show("Getting Stock Price for \(stockName)")
        AF.request(stockURL).responseJSON {(response) in
            SwiftSpinner.hide()
            
            //if response.result.isSuccess{
            switch response.result {
                case .success:
                    guard let jsonString = response.result.value else { return }
                    guard let stockJSON : [JSON] = JSON(jsonString).array else { return }
                    
                    if stockJSON.count < 1 { return }
                    guard let price = stockJSON[0]["price"].double else { return }
                    guard let ceo = stockJSON[0]["ceo"].rawString() else { return }
                    
                    self.lblStockPrice.text = "\(price)"
                    self.lblCEO.text = "\(ceo)"
                case .failure:
                    print("failure")
                
            }
        }
    }
}
