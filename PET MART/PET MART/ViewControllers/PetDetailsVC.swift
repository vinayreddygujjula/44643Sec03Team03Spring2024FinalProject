//
//  PetDetailsVC.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 4/6/24.
//

import UIKit
import SDWebImage

class PetDetailsVC: UIViewController {
    
    @IBOutlet weak var petIV: UIImageView!
    @IBOutlet weak var imageChangePC: UIPageControl!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var typeBreedLBL: UILabel!
    @IBOutlet weak var descriptionLBL: UITextView!
    @IBOutlet weak var contactLBL: UITextView!
    
    var petID : Int = 0
    var petImages = [String]()
    var imageIndex = 0
    var data = Animal.init(id: 0, type: "", breeds: Breeds(primary: "", secondary: "", mixed: false, unknown: false), gender: "", name: "", description: "", photos: [Photos.init(small: "", medium: "", large: "", full: "")], contact: Contact(email: "", phone: "", address: Address(address1: "", address2: "", city: "", state: "", postcode: "", country: "")))
    
    func setupImageView() {
        self.petIV.isUserInteractionEnabled = true
        self.petIV.sd_setImage(with: URL(string: petImages[imageIndex]), completed: nil)
        self.addSwipeGestures()
        self.imageChangePC.numberOfPages = petImages.count
        self.imageChangePC.currentPage = imageIndex
    }
    
    func addSwipeGestures(){
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler))
        leftSwipeGesture.direction = .left
        self.petIV.addGestureRecognizer(leftSwipeGesture)
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler))
        rightSwipeGesture.direction = .right
        self.petIV.addGestureRecognizer(rightSwipeGesture)
    }
    
    @objc func swipeGestureHandler(swipeGesture: UISwipeGestureRecognizer) {
        if swipeGesture.direction == .left {
            if self.imageIndex == petImages.count - 1 { return }
            self.imageIndex = (self.imageIndex + 1) % petImages.count
            self.petIV.sd_setImage(with: URL(string: petImages[self.imageIndex]), completed: nil)
            self.imageChangePC.currentPage = self.imageIndex
        } else if swipeGesture.direction == .right {
            if self.imageIndex == 0 { return }
            self.imageIndex = (imageIndex - 1 + petImages.count) % petImages.count
            self.petIV.sd_setImage(with: URL(string: petImages[self.imageIndex]), completed: nil)
            self.imageChangePC.currentPage = self.imageIndex
        }
    }
    
    func showPetDetails(){
        self.nameLBL.text = data.name
        self.typeBreedLBL.text = "\(data.type) - \(data.breeds.primary ?? "Unknown")"
        self.descriptionLBL.text = data.description
        self.contactLBL.text = data.contact.toString()
        if let petPhotos = data.photos, petPhotos.count != 0 {
            petPhotos.forEach{ photo in
                petImages.append(photo.small!)
                petImages.append(photo.medium!)
                petImages.append(photo.large!)
                petImages.append(photo.full!)
            }
        }
        if petImages.count != 0 {
            self.setupImageView()
        } 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPetDetails()
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
