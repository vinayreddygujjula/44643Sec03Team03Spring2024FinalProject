//
//  PetListViewController.swift
//  PET MART
//
//  Created by Lakshmi Sai Teja Padam on 4/12/24.
//

import UIKit

struct Pet {
    var name: String
    var description: String
    var price: Double
    var imageName: String
}


class PetListViewController: UITableViewController {
    var pets: [Pet] = [
        Pet(name: "Dog", description: "A friendly dog", price: 300.0, imageName: "dog"),
        Pet(name: "Cat", description: "A sleepy cat", price: 150.0, imageName: "cat"),
        Pet(name: "Rabbit", description: "A cute rabbit", price: 90.0, imageName: "rabbit")
    ]

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetCell", for: indexPath)
        cell.textLabel?.text = pets[indexPath.row].name
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! PetControlDescriptionPageVC
                destinationVC.pet = pets[indexPath.row]
            }
        }
    }
}
