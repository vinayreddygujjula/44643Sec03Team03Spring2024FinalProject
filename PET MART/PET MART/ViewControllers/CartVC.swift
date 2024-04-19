//
//  CartVC.swift
//  PET MART
//
//  Created by Avinash Chinnala  on 4/5/24.
//

import UIKit
import Firebase
import SDWebImage
import AVFoundation
import Social

class CartVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var productTV: UITableView!
    @IBOutlet weak var messageLBL: UILabel!
    
    let db = Firestore.firestore()
    let currentUserID = Auth.auth().currentUser?.uid
    let clearSound : SystemSoundID = 1152
    let buttonClickSound : SystemSoundID = 1104
    
    struct CartItem {
        let productID: String
        let productPrice: Double
        let productName: String
        let productImage: String
        var cartCount: Int
    }
    
    var cartItems: [CartItem] = []{
        didSet{
            self.messageLBL.isHidden = !cartItems.isEmpty
        }
    }
    var totalPrice: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTV.delegate = self
        self.productTV.dataSource = self
        resetCart()
    }
    
    func calculateTotalPrice() async{
        totalPrice = 0.0
        guard let userID = currentUserID else { return }
        var documents: [QueryDocumentSnapshot] = []
        do{
            documents = try await db.collection("CartProducts")
                .whereField("userID", isEqualTo: userID).getDocuments().documents
        }
        catch{
            print(error.localizedDescription)
            return
        }
        for i in 0..<documents.count{
            if let productPrice = documents[i]["productPrice"] as? Double,
               let cartCount = documents[i]["cartCount"] as? Int{
                totalPrice = totalPrice + (productPrice * Double(cartCount))
                print("total price \(totalPrice)")
                print(cartItems)
                cartItems[i].cartCount = cartCount
            }
        }
    }
    
    @IBAction func buyCart(_ sender: UIButton) {
        
        if(self.cartItems.isEmpty){ return }
        
        Task{
            await calculateTotalPrice()
            
            let TotalPrice = String(format: "%.2f", totalPrice)
            
            let confirmAlert = UIAlertController(title: "Confirm Order", message: "Do you want to make the total purchase of amount  $\(TotalPrice)?", preferredStyle: .alert)
            confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
                let cartlist = self.cartItems
                var productNames = []
                for i in 0..<cartlist.count {
                    let productID = Int(cartlist[i].productID)!
                    productNames.append(cartlist[i].productName)
                    Task{
                        await self.deleteCartProducts(productID: productID)
                    }
                }
                self.resetCart()
                let thanksmsg = UIAlertController(title: "Thank You", message: "Thanks for shopping with us!", preferredStyle: .alert)
                thanksmsg.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                thanksmsg.addAction(UIAlertAction(title: "Share", style: .default, handler: { _ in
                    let activityViewController = UIActivityViewController(activityItems: productNames, applicationActivities: nil)
                    self.present(activityViewController, animated: true)
                }))
                self.present(thanksmsg, animated: true, completion: nil)
            }))
            
            self.present(confirmAlert, animated: true, completion: nil)
        }
        
        
        AudioServicesPlaySystemSound(buttonClickSound)
    }
    
    @IBAction func clearCart(_ sender: UIButton) {
        
        if(self.cartItems.isEmpty){ return }
        
        let clearAction = UIAlertController(title: "Clear Cart", message: "Do you wish to clear items in your cart?", preferredStyle: .alert)
        clearAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        clearAction.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { _ in
            let cartlist = self.cartItems
            for i in 0..<cartlist.count {
                let productID = Int(cartlist[i].productID)!
                Task{
                    await self.deleteCartProducts(productID: productID)
                }
            }
            self.productTV.reloadData()
            let clearAlert = UIAlertController(title: "Clear Cart", message: "Your cart has been cleared", preferredStyle: .alert)
            clearAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(clearAlert, animated: true, completion: nil)
            self.resetCart()
        }))
        
        self.present(clearAction, animated: true, completion: nil)
        
        AudioServicesPlaySystemSound(clearSound)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! TableViewCell
        let item = cartItems[indexPath.row]
        let thumbnailImage = item.productImage.replacingOccurrences(of: "Optional(\"", with: "").replacingOccurrences(of: "\")", with: "")
        cell.setCellData(thumbnail: thumbnailImage, title: item.productName, price: "\(item.productPrice)", cartCount: item.cartCount)
        cell.productID = item.productID
        Common.applyBorderProperties(to: cell)
        cell.contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func fetchCartDetails() async throws{
        
        guard let userID = currentUserID else { return }
        
        var documents: [QueryDocumentSnapshot] = []
        do{
            documents = try await db.collection("CartProducts")
                .whereField("userID", isEqualTo: userID).getDocuments().documents
        }
        catch{
            print(error.localizedDescription)
            return
        }
        for i in 0..<documents.count{
            if let productID = documents[i]["productID"] as? String,
               let productPrice = documents[i]["productPrice"] as? Double,
               let productName = documents[i]["productName"] as? String,
               let cartCount = documents[i]["cartCount"] as? Int,
               let productImage = documents[i]["productImage"] as? String {
                let cartItem = CartItem(productID: productID, productPrice: productPrice, productName: productName, productImage: productImage, cartCount: cartCount)
                self.cartItems.append(cartItem)
                self.totalPrice = self.totalPrice + (productPrice * Double(cartCount))
                print(totalPrice)
                print(cartCount)
            }
        }
        
        self.productTV.reloadData()
    }
    
    func resetCart() {
        cartItems = []
        totalPrice = 0.0
        Task{
            try await self.fetchCartDetails()
        }
        productTV.reloadData()
        messageLBL.isHidden = !cartItems.isEmpty
    }
    
    func deleteCartProducts(productID : Int) async {
        let key = "\(String(describing: currentUserID))-\(productID)"
        let docID = key.replacingOccurrences(of: "Optional(\"", with: "").replacingOccurrences(of: "\")", with: "")
        do{
            try await db.collection("CartProducts").document(docID).delete()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(5)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let currentUserID = Auth.auth().currentUser?.uid
        let key = "\(String(describing: currentUserID))-\(cartItems[indexPath.row].productID)"
        let docID = key.replacingOccurrences(of: "Optional(\"", with: "").replacingOccurrences(of: "\")", with: "")
        let removeFromCartAction = UIContextualAction(style: .normal, title: "-"){ [weak self] (_, _, completion) in
            Task{
                await self?.removeProductFromCart(docID: docID)
                self?.cartItems.remove(at: indexPath.row)
                self?.productTV.reloadData()
            }
            completion(true)
        }
        removeFromCartAction.backgroundColor = UIColor(named: "red")
        return UISwipeActionsConfiguration(actions: [removeFromCartAction])
    }
    
    func removeProductFromCart(docID : String) async{
        do{
            try await db.collection("CartProducts").document(docID).delete()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

