//
//  ProductVC.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 4/7/24.
//

import UIKit

class ProductVC: UIView {

    @IBOutlet weak var ProductIV: UIImageView!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var ratingLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    
    var product = Product(id: 0, name: "", price: "", image1: "", image2: "", image3: "", rating: "", thumbnail: "", description: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    func loadView() {
        let nib = UINib(nibName: "ProductView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
