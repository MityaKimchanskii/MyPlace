//
//  StorageManager.swift
//  MyPlace
//
//  Created by Mitya Kim on 29.10.2020.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ place: Place) {
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deletedObject(_ place: Place) {
        try! realm.write {
            realm.delete(place)
        }
    }
}
