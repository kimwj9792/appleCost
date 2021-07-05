//
//  itemCell.swift
//  appleMin
//
//  Created by 김우재 on 2021/05/10.
//

import UIKit

class itemCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    var URL: String!
    var highPrice: Int!
    var lowPrice: Int!
    var priceArray: [Int]!
    var dateArray: [String]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
