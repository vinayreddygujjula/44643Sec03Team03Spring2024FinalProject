//
//  ResetPasswordVC.swift
//  PET MART
//
//  Created by Avinash Chinnala  on 3/9/24.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var SecurityQuestionTF: UITextField!
    @IBOutlet weak var ResetPasswordTF: UITextField!
    @IBOutlet weak var ConfirmPasswordTF: UITextField!
    @IBOutlet weak var resetBTN: UIButton!
    
    @IBAction func ResetBTN(_ sender: UIButton) {
        
        guard let email = self.EmailTF.text, !email.isEmpty, Common.isValidEmail(email)
        else{
            self.EmailTF.layer.borderColor = UIColor.red.cgColor
            return
        }
        self.EmailTF.layer.borderColor = UIColor.black.cgColor
        
        guard let securityQuestion = self.SecurityQuestionTF.text, !securityQuestion.isEmpty
        else{
            self.SecurityQuestionTF.layer.borderColor = UIColor.red.cgColor
            return
        }
        self.SecurityQuestionTF.layer.borderColor = UIColor.black.cgColor
        
        
        guard let password = self.ResetPasswordTF.text, !password.isEmpty
        else{
            self.ResetPasswordTF.layer.borderColor = UIColor.red.cgColor
            return
        }
        self.ResetPasswordTF.layer.borderColor = UIColor.black.cgColor
        
        guard let cnfrmPassword = self.ConfirmPasswordTF.text, !cnfrmPassword.isEmpty, cnfrmPassword == password
        else{
            self.ConfirmPasswordTF.layer.borderColor = UIColor.red.cgColor
            return
        }
        self.ConfirmPasswordTF.layer.borderColor = UIColor.black.cgColor
        
        self.performSegue(withIdentifier: "login", sender: sender)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "login" :
            guard let destinationVC = segue.destination as? LoginVC
            else{
                return
            }
        default :
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Common.applyBorderProperties(to: EmailTF)
        Common.applyBorderProperties(to: ResetPasswordTF)
        Common.applyBorderProperties(to: ConfirmPasswordTF)
        Common.applyBorderProperties(to: SecurityQuestionTF)
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
