//
//  AddPetViewController.swift
//  PET MART
//
//  Created by Lakshmi Sai Teja Padam on 4/12/24.
//

import UIKit

class AddPetViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func addPetButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty,
              let priceText = priceTextField.text, let price = Double(priceText) else {
            
            return
        }
        
        let newPet = Pet(name: name, description: description, price: price, imageName: "default")
    }
}
