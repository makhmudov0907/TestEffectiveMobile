//
//  APIManager.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 22/06/24.
//

import Foundation

//MARK: - Structures for API Data
//MARK: For Tickets
struct TicketResponse: Codable {
    let tickets: [Ticket]
}
struct Ticket: Codable, Identifiable {
    let id: Int
    let badge: String?
    let price: Price
    let providerName: String
    let company: String
    let departure: Locations
    let arrival: Locations
    let hasTransfer: Bool
    let hasVisaTransfer: Bool
    let luggage: Luggage
    let handLuggage: HandLuggage?
    let isReturnable: Bool
    let isExchangable: Bool

    enum CodingKeys: String, CodingKey {
        case id, badge, price, company, departure, arrival, luggage, handLuggage
        case providerName = "provider_name"
        case hasTransfer = "has_transfer"
        case hasVisaTransfer = "has_visa_transfer"
        case isReturnable = "is_returnable"
        case isExchangable = "is_exchangable"
    }
}

struct Price: Codable {
    let value: Int
}

struct Locations: Codable {
    let town: String
    let date: String
    let airport: String
}

struct Luggage: Codable {
    let hasLuggage: Bool
    let price: Price?

    enum CodingKeys: String, CodingKey {
        case hasLuggage = "has_luggage"
        case price
    }
}

struct HandLuggage: Codable {
    let hasHandLuggage: Bool
    let size: String?

    enum CodingKeys: String, CodingKey {
        case hasHandLuggage = "has_hand_luggage"
        case size
    }
}

//MARK: For Tickets
struct TicketOffer: Codable, Identifiable {
    let id: Int
    let title: String
    let timeRange: [String]
    let price: Price

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case timeRange = "time_range"
    }
}

//MARK: For ConcertOffer
struct ConcertOffer: Codable, Identifiable {
    let id: Int
    let title: String
    let town: String
    let price: Price
    var imageName: String?
}

// MARK: - API Manager
class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func fetchTickets(completion: @escaping (Result<[Ticket], Error>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/c0464573-5a13-45c9-89f8-717436748b69") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let ticketResponse = try JSONDecoder().decode(TicketResponse.self, from: data)
                completion(.success(ticketResponse.tickets))
            } catch {
                print("JSON Decoding Error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchTicketOffers(completion: @escaping (Result<[TicketOffer], Error>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/38b5205d-1a3d-4c2f-9d77-2f9d1ef01a4a") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([String: [TicketOffer]].self, from: data)
                if let offers = result["tickets_offers"] {
                    completion(.success(offers))
                } else {
                    completion(.failure(NSError(domain: "No tickets_offers key", code: 404, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchConcertOffers(completion: @escaping (Result<[ConcertOffer], Error>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/ad9a46ba-276c-4a81-88a6-c068e51cce3a") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([String: [ConcertOffer]].self, from: data)
                if let offers = result["offers"] {
                    completion(.success(offers))
                } else {
                    completion(.failure(NSError(domain: "No offers key", code: 404, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
