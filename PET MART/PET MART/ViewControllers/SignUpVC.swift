//
//  SignUpVC.swift
//  PET MART
//
//  Created by Hema Likhitha Adapa on 3/7/24.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet weak var FirstNameTF: UITextField!
    @IBOutlet weak var LastnameTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var ConfirmpasswordTF: UITextField!
    @IBOutlet weak var SignUpBTN: UIButton!

    @IBAction func signUpAction(_ sender: UIButton) {
        
        guard let firstName = self.FirstNameTF.text, !firstName.isEmpty
        else{
            self.FirstNameTF.layer.borderColor = UIColor.red.cgColor
            return
        }
        self.FirstNameTF.layer.borderColor = UIColor.black.cgColor
        
        guard let lastName = self.LastnameTF.text, !lastName.isEmpty
        else{
            self.LastnameTF.layer.borderColor = UIColor.red.cgColor
            return
        }
        self.LastnameTF.layer.borderColor = UIColor.black.cgColor
        
        guard let email = self.EmailTF.text, !email.isEmpty, Common.isValidEmail(email)
        else{
            self.EmailTF.layer.borderColor = UIColor.red.cgColor
            return
        }
        self.EmailTF.layer.borderColor = UIColor.black.cgColor
        
        guard let password = self.PasswordTF.text, !password.isEmpty
        else{
            self.PasswordTF.layer.borderColor = UIColor.red.cgColor
            return
        }
        self.PasswordTF.layer.borderColor = UIColor.black.cgColor
        
        guard let cnfrmPassword = self.ConfirmpasswordTF.text, !cnfrmPassword.isEmpty, cnfrmPassword == password
        else{
            self.ConfirmpasswordTF.layer.borderColor = UIColor.red.cgColor
            return
        }
        self.ConfirmpasswordTF.layer.borderColor = UIColor.black.cgColor

        Task{
            do {
                try await AuthenticationManager.shared.createUser(email: email, password: password, username: firstName)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        self.performSegue(withIdentifier: "home", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Common.applyBorderProperties(to: FirstNameTF)
        Common.applyBorderProperties(to: LastnameTF)
        Common.applyBorderProperties(to: EmailTF)
        Common.applyBorderProperties(to: PasswordTF)
        Common.applyBorderProperties(to: ConfirmpasswordTF)
        
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
