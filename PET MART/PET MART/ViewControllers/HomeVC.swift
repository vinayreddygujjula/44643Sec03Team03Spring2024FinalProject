//
//  HomeVC.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 3/7/24.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    @IBOutlet weak var PetBTN: UIButton!
    @IBOutlet weak var ProductBTN: UIButton!
    
    @IBOutlet weak var userNameLBL: UILabel!
    
    
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        Task{
            do{
                try AuthenticationManager.shared.signOut()
            }
            catch{
                print(error.localizedDescription)
            }
        }
        self.performSegue(withIdentifier: "homeToLogin", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNameLBL.text = Auth.auth().currentUser?.displayName
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


