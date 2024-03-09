//
//  ViewController.swift
//  PET MART
//
//  Created by Hema Likhitha Adapa on 2/21/24.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    @IBOutlet weak var LoginScreening: UIImageView!
    
    @IBOutlet weak var UsernameSV: UIStackView!
    
    
    @IBOutlet weak var LoginB: UIButton!
    
    @IBOutlet weak var PasswordTF: UITextField!
    
    
    @IBOutlet weak var UsernameTF: UITextField!
    
    
    @IBOutlet weak var emailL: UILabel!
    
    
    @IBOutlet weak var passwordL: UILabel!
    
    @IBOutlet weak var signup: UILabel!
    
    
    
    
    @IBOutlet weak var LaunchLAV: LottieAnimationView!
    {
        didSet{
            LaunchLAV.loopMode = .playOnce
            LaunchLAV.animationSpeed = 1.0
            LaunchLAV.play { [weak self] _ in
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 1.0,
                    delay: 0.0,
                    options:[.curveEaseInOut]){
                        self?.LaunchLAV.alpha = 0.0
                    }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Login(_ sender: UIButton) {
    }
    @IBAction func username(_ sender: Any) {
    }
    @IBAction func password(_ sender: UITextField) {
    }
    
    
    @IBOutlet weak var EmailTF: UITextField!
    
    @IBAction func SendaCode(_ sender: UIButton) {
    }
}

