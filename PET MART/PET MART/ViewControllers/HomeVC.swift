//
//  HomeVC.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 3/7/24.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var ImageIV: UIImageView!
    
    @IBOutlet weak var ImageScrollView: UIScrollView!
    var timer: Timer?
    @IBOutlet weak var SearchTF: UITextField!
    
    
    @IBOutlet weak var PetBTN: UIButton!
    
    @IBOutlet weak var ProductBTN: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        
    }
      
    
    
}
    

    
    
    
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


