//
//  ConcertOffersViewModel.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 22/06/24.
//

import Foundation
import Combine

class ConcertOffersViewModel: ObservableObject {
    @Published var concertOffers: [ConcertOffer] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let images = ["profile2", "profile1", "profile3"]
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchConcertOffers()
    }
    
    deinit {
        cancellables.removeAll()
    }

    func fetchConcertOffers() {
        isLoading = true
        APIManager.shared.fetchConcertOffers { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let offers):
                    // Свяжем предложения с изображениями
                    self?.concertOffers = offers.enumerated().map { index, offer in
                        var offerWithImage = offer
                        offerWithImage.imageName = self?.images[index % self!.images.count] ?? ""
                        return offerWithImage
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
