//
//  TableViewCell.swift
//  PET MART
//
//  Created by Avinash Chinnala  on 4/11/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var productIV: UIImageView!
    
    
    func setCellData(thumbnail:String, title:String, price:String) {
        self.titleLBL.text = title
        self.priceLBL.text = "$\(price)"
        self.productIV.sd_setImage(with: URL(string: thumbnail), placeholderImage: UIImage(named: "placeholder"))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
