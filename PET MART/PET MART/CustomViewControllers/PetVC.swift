//
//  PetViewVC.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 4/6/24.
//

import UIKit

class PetVC: UIView {

    @IBOutlet weak var PetIV: UIImageView!
    @IBOutlet weak var NameLBL: UILabel!
    @IBOutlet weak var TypeBreedLBL: UILabel!
    @IBOutlet weak var GenderLBL: UILabel!
    
    var pet = Animal.init(id: 0, type: "", breeds: Breeds(primary: "", secondary: "", mixed: false, unknown: false), gender: "", name: "", description: "", photos: [Photos.init(small: "", medium: "", large: "", full: "")], contact: Contact(email: "", phone: "", address: Address(address1: "", address2: "", city: "", state: "", postcode: "", country: "")))
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    func loadView() {
        let nib = UINib(nibName: "PetView", bundle: nil)
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
