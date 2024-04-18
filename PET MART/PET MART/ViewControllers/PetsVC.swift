//
//  PetsVC.swift
//  PET MART
//
//  Created by Avinash Chinnala  on 4/5/24.
//

import UIKit
import SDWebImage
import AVFoundation

class PetsVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var petScrollView: UIScrollView!
    @IBOutlet weak var petStackView: UIStackView!
    var data : [Animal] = []
    let buttonClickSound : SystemSoundID = 1104
    
    private func showMenu() {
        data.forEach { item in
            let view = PetVC()
            view.pet = item
            if item.photos != nil, let thumbnailImage = item.photos?.first?.small{
                view.PetIV.sd_setImage(with: URL(string: thumbnailImage))
            }
            view.NameLBL.text = item.name
            view.TypeBreedLBL.text = String(format: "\(item.type)")
            view.GenderLBL.text = item.gender
            view.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            tapGesture.numberOfTapsRequired = 1
            view.addGestureRecognizer(tapGesture)
            self.petStackView.addArrangedSubview(view)
            Common.applyBorderProperties(to: view)
        }
    }
    
    @objc private func handleTap(_ recognizer: UITapGestureRecognizer){
        switch (recognizer.state){
        case .ended:
            guard let itemView = recognizer.view as? PetVC else {return}
            self.performSegue(withIdentifier: "petsToPetDetail", sender: itemView)
        default:
            assert (false, "Invalid segue!")
        }
        AudioServicesPlaySystemSound(buttonClickSound)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "petsToPetDetail",
           let destinationVC = segue.destination as? PetDetailsVC,
           let pet = sender as? PetVC {
            destinationVC.data = pet.pet
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.petScrollView.delegate = self
        
        Task {
            data = try await APIService.shared.fetchAnimalsData()
            showMenu()
        }
    }
    
}
