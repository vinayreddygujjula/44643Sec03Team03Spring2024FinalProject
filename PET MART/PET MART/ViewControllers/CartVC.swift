//
//  CartVC.swift
//  PET MART
//
//  Created by Avinash Chinnala  on 4/5/24.
//

import UIKit
import Firebase
import SDWebImage


class CartVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var productTV: UITableView!
    @IBOutlet weak var messageLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    
    
    let db = Firestore.firestore()
    let currentUserID = Auth.auth().currentUser?.uid
    
    struct CartItem {
        let productID: String
        let productPrice: Double
        let productName: String
        let productImage: String
    }
    
    var cartItems: [CartItem] = []
    var totalPrice: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTV.delegate = self
        self.productTV.dataSource = self
        Task{
           try await fetchCartDetails()
        }
        
    }
    
    @IBAction func buyCart(_ sender: UIButton) {
        if(self.cartItems.isEmpty){ return }
        let confirmAlert = UIAlertController(title: "Confirm Order", message: "Do you want to make the total purchase of amount $\(totalPrice)?", preferredStyle: .alert)
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            let cartlist = self.cartItems
            for i in 0..<cartlist.count {
                let productID = Int(cartlist[i].productID)!
                Task{
                    await self.deleteCartProducts(productID: productID)
                }
            }
            self.removeitemsfromcart()
            let thanksmsg = UIAlertController(title: "Thank You", message: "Thanks for shopping with us!", preferredStyle: .alert)
            thanksmsg.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(thanksmsg, animated: true, completion: nil)
        }))
        self.present(confirmAlert, animated: true, completion: nil)
        self.productTV.reloadData()
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
            let clearAlert = UIAlertController(title: "Clear Cart", message: "Your cart has been cleared", preferredStyle: .alert)
            clearAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(clearAlert, animated: true, completion: nil)
        }))
        self.present(clearAction, animated: true, completion: nil)
        self.removeitemsfromcart()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! TableViewCell
        let item = cartItems[indexPath.row]
        cell.setCellData(thumbnail: item.productImage, title: item.productName, price: "\(item.productPrice)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func fetchCartDetails() async throws{
        var documents: [QueryDocumentSnapshot] = []
        do{
            documents = try await db.collection("CartProducts")
                .whereField("userID", isEqualTo: currentUserID).getDocuments().documents
        }
        catch{
            print("--------")
            return
        }
        for i in 0..<documents.count{
            if let productID = documents[i]["productID"] as? String,
               let productPrice = documents[i]["productPrice"] as? Double,
               let productName = documents[i]["productName"] as? String,
               let productImage = documents[i]["productImage"] as? String {
                let cartItem = CartItem(productID: productID, productPrice: productPrice, productName: productName, productImage: productImage)
                self.cartItems.append(cartItem)
                self.totalPrice += productPrice
                self.priceLBL.text = String(format: "Total price: \(totalPrice)")
            }
        }
        self.productTV.reloadData()
    }
    
    func removeitemsfromcart() {
        productTV.reloadData()
        messageLBL.isHidden = !cartItems.isEmpty
        messageLBL.text = cartItems.isEmpty ? "Your cart is empty" : ""
    }
    
    func deleteCartProducts(productID : Int) async {
        do{
            print("-------------------")
            if let unwrappedString = currentUserID
            {
                print(unwrappedString)
            }
            print(productID)
            print("-------------------")
            let documents = try await db.collection("CartProducts")
                .whereField("userID", isEqualTo: currentUserID)
                .whereField("productID", isEqualTo: productID)
                .getDocuments().documents
            print("-------------------")
            print(documents)
            print("-------------------")
            //try await db.collection("CartProducts").getDocuments().documents[documents].delete()
        }
        catch {
            print(error.localizedDescription)
        }
        self.productTV.reloadData()
    }
}

