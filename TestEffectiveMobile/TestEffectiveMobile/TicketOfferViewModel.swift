//
//  TicketOfferViewModel.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 22/06/24.
//

import Foundation
import SwiftUI
import Combine

class TicketOfferViewModel: ObservableObject {
    @Published var ticketOffers: [TicketOffer] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let colors: [Color] = [.red, .blue, .white, .orange, .purple, .pink]

    init() {
        fetchTicketOffers()
    }

    deinit {
        cancellables.removeAll()
    }
    
    func fetchTicketOffers() {
        isLoading = true
        APIManager.shared.fetchTicketOffers { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let offers):
                    self?.ticketOffers = offers
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getColor(for index: Int) -> Color {
        return colors[index % colors.count]
    }
}
