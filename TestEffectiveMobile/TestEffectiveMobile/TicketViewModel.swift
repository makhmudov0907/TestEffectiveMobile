//
//  TicketViewModel.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 22/06/24.
//

import Foundation
import SwiftUI
import Combine

class TicketViewModel: ObservableObject {
    @Published var tickets: [Ticket] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let colors: [Color] = [.red, .blue, .white, .orange, .purple, .pink]

    init() {
        fetchTickets()
    }

    deinit {
        cancellables.removeAll()
    }

    func fetchTickets() {
        isLoading = true
        APIManager.shared.fetchTickets { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let tickets):
                    self?.tickets = tickets
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getColor(for index: Int) -> Color {
        return colors[index % colors.count]
    }
    
    func formatDateToTime(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            return date.formattedTime()
        }
        return "N/A"
    }
    //MARK: Рассчет времени полета
    func calculateDuration(departure: String, arrival: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let departureDate = dateFormatter.date(from: departure),
              let arrivalDate = dateFormatter.date(from: arrival) else {
            return "N/A"
        }
        
        let duration = arrivalDate.timeIntervalSince(departureDate)
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        
        return "\(hours) ч \(minutes) мин"
    }
}

extension Date {
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
