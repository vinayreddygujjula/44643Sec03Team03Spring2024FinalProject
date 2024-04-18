//
//  ProductsVC.swift
//  PET MART
//
//  Created by Avinash Chinnala  on 4/5/24.
//

import UIKit
import SDWebImage
import AVFoundation

class ProductsVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var productScrollView: UIScrollView!
    @IBOutlet weak var productStackView: UIStackView!
    
    var data : [Product] = []
    let buttonClickSound : SystemSoundID = 1104
    
    private func showMenu(){
        data.forEach { item in
            let view = ProductVC()
            view.product = item
            view.ProductIV.sd_setImage(with: URL(string: item.thumbnail))
            view.nameLBL.text = item.name
            view.descriptionLBL.text = item.description
            if item.rating != nil, let rating = item.rating, let ratingLBL = view.ratingLBL.text{
                view.ratingLBL.text = String(format:"\(ratingLBL) \(rating)")
            }
            if item.price != nil, let price = item.price {
                view.priceLBL.text = String(format:"$ \(price)")
            }
            view.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            tapGesture.numberOfTapsRequired = 1
            view.addGestureRecognizer(tapGesture)
            self.productStackView.addArrangedSubview(view)
            Common.applyBorderProperties(to: view)
        }
    }
    
    @objc private func handleTap(_ recognizer: UITapGestureRecognizer){
        switch (recognizer.state){
        case .ended:
            guard let itemView = recognizer.view as? ProductVC else {return}
            self.performSegue(withIdentifier: "productToProductDetail", sender: itemView)
        default:
            assert (false, "Invalid segue!")
        }
        AudioServicesPlaySystemSound(buttonClickSound)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productToProductDetail",
           let destinationVC = segue.destination as? ProductDetailsVC,
           let product = sender as? ProductVC {
            destinationVC.data = product.product
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productScrollView.delegate = self
        
        Task{
            data = try await ProductAPIService.showProducts()
            showMenu()
        }
    }
}
