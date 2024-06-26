//
//  UserDefaultsManager.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 24/06/24.
//

import Foundation

//MARK: Для хранения данных поиска
class UserDefaultsManager {
    private static let departureKey = "departureCity"
    private static let arrivalKey = "arrivalCity"
    
    static func saveDepartureCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: departureKey)
    }
    
    static func loadDepartureCity() -> String {
        return UserDefaults.standard.string(forKey: departureKey) ?? ""
    }
    
    static func saveArrivalCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: arrivalKey)
    }
    
    static func loadArrivalCity() -> String {
        return UserDefaults.standard.string(forKey: arrivalKey) ?? ""
    }
}

