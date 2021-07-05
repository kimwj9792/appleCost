//
//  ViewController.swift
//  appleMin
//
//  Created by 김우재 on 2021/05/10.
//

import UIKit

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var jsonParsed: response!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let jsonDecoder: JSONDecoder = JSONDecoder()
        //        if let url = URL(string: "http://localhost:3000/items") {
        //            URLSession.shared.dataTask(with: url) { data, resp, error in
        //                if let data = data {
        //                    let jsonDecoder = JSONDecoder()
        //                    do {
        //                        self.jsonParsed = try jsonDecoder.decode(response.self, from: data)
        //                        print(self.jsonParsed)
        //                    } catch {
        //                        print(error)
        //                    }
        //                }
        //            }.resume()
        //        }
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "sample") else {
            return
        }
        
        do {
            self.jsonParsed = try jsonDecoder.decode(response.self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setPriceTextAndColor(label: UILabel, array: [Int]) {
        let gap: Int = array.last! - array.first!
        if gap < 0 { // 하락
            label.textColor = UIColor(red: 0.04, green: 0.52, blue: 0.89, alpha: 1.00)
            label.text =  "\(array.last!.withCommas()) 원 (▼ \((gap * -1).withCommas()))"
        }
        else if gap > 0 { // 상승
            label.textColor = UIColor(red: 0.84, green: 0.19, blue: 0.19, alpha: 1.00)
            label.text =  "\(array.last!.withCommas()) 원 (▲ \(gap.withCommas()))"
        }
        else { // 보합
            label.textColor = UIColor(red: 0.00, green: 0.72, blue: 0.58, alpha: 1.00)
            label.text =  "\(array.last!.withCommas()) 원 (▬ \(gap.withCommas()))"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "에어팟"
        case 1:
            return "충전기"
        case 2:
            return "악세사리"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return jsonParsed.airpods.count
        case 1:
            return jsonParsed.chargers.count
        case 2:
            return jsonParsed.accessories.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as? itemCell else {
            return itemCell()
        }
        let imageURL: URL
        switch indexPath.section {
        case 0: // airpod
            imageURL = URL(string: jsonParsed.airpods[indexPath.row].imageURL)!
            cell.itemNameLabel.text = jsonParsed.airpods[indexPath.row].name
            let arrayTwoDays: [Int] = Array(jsonParsed.airpods[indexPath.row].price.suffix(2))
            setPriceTextAndColor(label: cell.itemPriceLabel, array: arrayTwoDays)
            cell.URL = jsonParsed.airpods[indexPath.row].imageURL
            cell.highPrice = jsonParsed.airpods[indexPath.row].highPrice
            cell.lowPrice = jsonParsed.airpods[indexPath.row].lowPrice
            cell.dateArray = jsonParsed.airpods[indexPath.row].date
            cell.priceArray = jsonParsed.airpods[indexPath.row].price
            
        case 1: // charger
            imageURL = URL(string: jsonParsed.chargers[indexPath.row].imageURL)!
            cell.itemNameLabel.text = jsonParsed.chargers[indexPath.row].name
            let arrayTwoDays: [Int] = Array(jsonParsed.chargers[indexPath.row].price.suffix(2))
            setPriceTextAndColor(label: cell.itemPriceLabel, array: arrayTwoDays)
            cell.URL = jsonParsed.chargers[indexPath.row].imageURL
            cell.highPrice = jsonParsed.chargers[indexPath.row].highPrice
            cell.lowPrice = jsonParsed.chargers[indexPath.row].lowPrice
            cell.dateArray = jsonParsed.chargers[indexPath.row].date
            cell.priceArray = jsonParsed.chargers[indexPath.row].price
            
        case 2: // accessory
            imageURL = URL(string: jsonParsed.accessories[indexPath.row].imageURL)!
            cell.itemNameLabel.text = jsonParsed.accessories[indexPath.row].name
            let arrayTwoDays: [Int] = Array(jsonParsed.accessories[indexPath.row].price.suffix(2))
            setPriceTextAndColor(label: cell.itemPriceLabel, array: arrayTwoDays)
            cell.URL = jsonParsed.accessories[indexPath.row].imageURL
            cell.highPrice = jsonParsed.accessories[indexPath.row].highPrice
            cell.lowPrice = jsonParsed.accessories[indexPath.row].lowPrice
            cell.dateArray = jsonParsed.accessories[indexPath.row].date
            cell.priceArray = jsonParsed.accessories[indexPath.row].price
        default:
            return itemCell()
        }
        
        let imageData: Data = try! Data.init(contentsOf: imageURL)
        let image: UIImage = UIImage(data: imageData)!
        cell.itemImageView.image = image
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let nextViewController: DetailViewController = segue.destination as? DetailViewController else {
            return
        }
        guard let cell: itemCell = sender as? itemCell else {
            return
        }
        if segue.identifier == "detail" { // detail segway
            nextViewController.imageURL = cell.URL
            nextViewController.itemName = cell.itemNameLabel.text
            nextViewController.itemPrice = cell.itemPriceLabel
            nextViewController.highPrice = cell.highPrice
            nextViewController.lowPrice = cell.lowPrice
            nextViewController.dateArray = cell.dateArray
            nextViewController.priceArray = cell.priceArray
        }
    }
}

