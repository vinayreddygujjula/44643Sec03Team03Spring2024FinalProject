//
//  ProductDetailsVC.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 4/8/24.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var descriptionLBL: UITextView!
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var productPC: UIPageControl!
    @IBOutlet weak var ratingLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var buyBTN: UIButton!
    
    var productId : Int = 0
    var productImages = [String]()
    var imageIndex = 0
    var data = Product(id: 0, name: "", price: "", image1: "", image2: "", image3: "", rating: "", thumbnail: "", description: "")
    
    @IBAction func addToCart(_ sender: UIButton) {
        self.buyBTN.isUserInteractionEnabled = true
    }
    
    @IBAction func buy(_ sender: UIButton) {
        self.performSegue(withIdentifier: "productDetailsToCart", sender: sender)
    }
    
    func setupImageView() {
        self.productIV.isUserInteractionEnabled = true
        self.productIV.sd_setImage(with: URL(string: productImages[imageIndex]), completed: nil)
        self.addSwipeGestures()
        self.productPC.numberOfPages = productImages.count
        self.productPC.currentPage = imageIndex
    }
    
    func addSwipeGestures(){
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler))
        leftSwipeGesture.direction = .left
        self.productIV.addGestureRecognizer(leftSwipeGesture)
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler))
        rightSwipeGesture.direction = .right
        self.productIV.addGestureRecognizer(rightSwipeGesture)
    }
    
    @objc func swipeGestureHandler(swipeGesture: UISwipeGestureRecognizer) {
        if swipeGesture.direction == .left {
            if self.imageIndex == productImages.count - 1 { return }
            self.imageIndex = (self.imageIndex + 1) % productImages.count
            self.productIV.sd_setImage(with: URL(string: productImages[self.imageIndex]), completed: nil)
            self.productPC.currentPage = self.imageIndex
        } else if swipeGesture.direction == .right {
            if self.imageIndex == 0 { return }
            self.imageIndex = (imageIndex - 1 + productImages.count) % productImages.count
            self.productIV.sd_setImage(with: URL(string: productImages[self.imageIndex]), completed: nil)
            self.productPC.currentPage = self.imageIndex
        }
    }
    
    func showPetDetails(){
        self.nameLBL.text = data.name
        self.descriptionLBL.text = data.description
        if data.price != nil, let price = data.price {
            self.priceLBL.text = String(format:"$ \(price)")
        }
        if data.rating != nil, let rating = data.rating, let ratingLBL = self.ratingLBL.text{
            self.ratingLBL.text = String(format:"\(ratingLBL) \(rating)")
        }
        if data.image1 != nil, let image1 = data.image1 {
            self.productImages.append(image1)
        }
        if data.image2 != nil, let image2 = data.image2{
            self.productImages.append(image2)
        }
        if data.image3 != nil, let image3 = data.image3{
            self.productImages.append(image3)
        }
        setupImageView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buyBTN.isUserInteractionEnabled = false
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
