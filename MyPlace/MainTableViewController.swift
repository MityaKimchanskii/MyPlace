//
//  TableViewController.swift
//  MyPlace
//
//  Created by Mitya Kim on 26.10.2020.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {
    
    var places: Results<Place>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let place = places[indexPath.row]

        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)

      

        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true

        return cell
    }
    
    
    // MARK: - TableView Delegate
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 85
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let place = places[indexPath.row]
            StorageManager.deletedObject(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let place = places[indexPath.row]
//
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
//            StorageManager.deletedObject(place)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//
//        }
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//
//
//    }
  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let place = places[indexPath.row]
            let newPlaceVC = segue.destination as! NewPlaceTableViewController
            newPlaceVC.currentPlace = place
            
            
        }
        
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newPlaceVC = segue.source as? NewPlaceTableViewController else { return }
        newPlaceVC.savePlace()
//        places.append(newPlaceVC.newPlace!)
        tableView.reloadData()
    }

}
