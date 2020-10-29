//
//  PlaceModel.swift
//  MyPlace
//
//  Created by Mitya Kim on 27.10.2020.
//

import UIKit

struct Place {
    
    static let restaurantNames = [
        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Вкусные истории",
        "Классик", "Love&Life", "Шок", "Бочка"
    ]
    
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var RestaurantImage: String?
    
    static func getPlaces() -> [Place] {
        
        var places = [Place]()
        
        for place in restaurantNames {
            places.append(Place(name: place, location: "Miami", type: "Disco", image: nil, RestaurantImage: place))
        }
        
        return places
    }
    
}
