//
//  HomeVC.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 3/7/24.
//

import UIKit
import Firebase
import AVFoundation

class HomeVC: UIViewController {
    
    @IBOutlet weak var userNameLBL: UILabel!
    
    let logoutSound : SystemSoundID = 1152
    let buttonClickSound : SystemSoundID = 1104
    
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
        AudioServicesPlaySystemSound(logoutSound)
    }
    
    @IBAction func navigateToPetsScreen(_ sender: UIButton) {
        AudioServicesPlaySystemSound(buttonClickSound)
    }
    
    @IBAction func navigateToProductScreen(_ sender: UIButton) {
        AudioServicesPlaySystemSound(buttonClickSound)
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


