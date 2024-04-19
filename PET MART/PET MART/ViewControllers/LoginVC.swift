//
//  ViewController.swift
//  PET MART
//
//  Created by Hema Likhitha Adapa on 2/21/24.
//

import UIKit
import Lottie
import Firebase
import AVFoundation

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var messageLBL: UILabel!
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
    
    var buttonClickSound : SystemSoundID = 1104
    
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
        
        Task{
            do{
                try await AuthenticationManager.shared.signIn(email: email, password: password)
                self.performSegue(withIdentifier: "loginToHome", sender: sender)
            }
            catch{
                print(error.localizedDescription)
                self.messageLBL.text = "Invalid credentials!"
                return
            }
        }
       // self.performSegue(withIdentifier: "loginToHome", sender: sender)
        AudioServicesPlaySystemSound(buttonClickSound)

    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        AudioServicesPlaySystemSound(buttonClickSound)
    }
    
    @IBAction func resetPasswordAction(_ sender: UIButton) {
        AudioServicesPlaySystemSound(buttonClickSound)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
        Common.applyBorderProperties(to: emailTF)
        Common.applyBorderProperties(to: passwordTF)
    }
    
    
    
}

