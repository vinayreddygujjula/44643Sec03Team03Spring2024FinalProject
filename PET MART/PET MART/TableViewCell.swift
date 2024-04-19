//
//  TableViewCell.swift
//  PET MART
//
//  Created by Avinash Chinnala  on 4/11/24.
//

import UIKit
import Firebase
import AVFoundation

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var productCountLBL: UILabel!
    @IBOutlet weak var cartStepper: UIStepper!
    
    var productID = ""
    var db = Firestore.firestore()
    var numIncDecSound : SystemSoundID = 1103
    
    @IBAction func changeCartCount(_ sender: UIStepper) {
        let newCount = Int(sender.value)
        productCountLBL.text = "\(newCount)"
        Task {
            await updateCartCount(cartCount: newCount, cell: self)
        }
        AudioServicesPlaySystemSound(numIncDecSound)
    }
    
    func updateCartCount(cartCount: Int, cell: TableViewCell) async {
        let currentUserID = Auth.auth().currentUser?.uid
        let key = "\(String(describing: currentUserID))-\(cell.productID)"
        let docID = key.replacingOccurrences(of: "Optional(\"", with: "").replacingOccurrences(of: "\")", with: "")
        Task {
            await updateProduct(documentID: docID, count: cartCount)
        }
    }
    
    func updateProduct(documentID: String, count : Int) async{
        print(documentID)
        //        if count == 0 {
        //            do{
        //                try await db.collection("CartProducts").document(documentID).delete()
        //            }
        //            catch {
        //                print(error.localizedDescription)
        //            }
        //        }
        //        else{
        do {
            try await db.collection("CartProducts").document(documentID).updateData([
                "cartCount" : count
            ])
        }
        catch {
            print("Error updating cart count: \(error)")
        }
        //        }
        
    }
    
    func setCellData(thumbnail: String, title: String, price: String, cartCount: Int) {
        self.titleLBL.text = title
        self.priceLBL.text = "$\(price)"
        self.productIV.sd_setImage(with: URL(string: thumbnail), placeholderImage: UIImage(named: "placeholder"))
        self.productCountLBL.text = "\(cartCount)"
        self.cartStepper.value = Double(cartCount)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Common.applyBorderProperties(to: productCountLBL)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
