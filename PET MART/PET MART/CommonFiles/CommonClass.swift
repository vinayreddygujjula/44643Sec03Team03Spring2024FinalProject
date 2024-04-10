//
//  CommonClass.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 3/9/24.
//

import Foundation
import UIKit

class Common{
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func applyBorderProperties(to element: UIView){
        element.layer.cornerRadius = 5.0
        element.layer.borderWidth = 1.0
        element.layer.borderColor = UIColor.black.cgColor
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case generalError
}
