//
//  ViewController.swift
//  PET MART
//
//  Created by Hema Likhitha Adapa on 2/21/24.
//

import UIKit
import Lottie

class LoginVC: UIViewController {
    
    
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
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        guard let email = self.emailTF.text, !email.isEmpty, Common.isValidEmail(email)
        else{
            self.emailTF.layer.borderColor = UIColor.red.cgColor
            return
        }
        self.emailTF.layer.borderColor = UIColor.black.cgColor
        guard let password = self.passwordTF.text, !password.isEmpty
        else{
            self.passwordTF.layer.borderColor = UIColor.red.cgColor
            return
        }
        self.passwordTF.layer.borderColor = UIColor.black.cgColor
        
        self.performSegue(withIdentifier: "home", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "home" :
            guard let destinationVC = segue.destination as? HomeVC
            else{
                return
            }
        case "signup" :
            guard let destinationVC = segue.destination as? SignUpVC
            else{
                return
            }
        case "reset" :
            guard let destinationVC = segue.destination as? ResetPasswordVC
            else{
                return
            }
        default :
            break
        }
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signup", sender: sender)
    }
    
    @IBAction func resetPasswordAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "reset", sender: sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Common.applyBorderProperties(to: emailTF)
        Common.applyBorderProperties(to: passwordTF)
    }
    
    
    
}

