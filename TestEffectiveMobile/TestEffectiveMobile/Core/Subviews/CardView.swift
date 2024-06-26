//
//  CardView.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 22/06/24.
//

import SwiftUI

struct CardView: View {
    let offer: ConcertOffer

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let imageName = offer.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 132, height: 133)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                // Место для заглушки, если изображение не указано
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 132, height: 133)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            Text(offer.title)
                .foregroundStyle(.white)
                .font(.headline)

            Text(offer.town)
                .font(.subheadline)
                .foregroundColor(.gray)

            HStack {
                Image(systemName: "airplane")
                    .foregroundColor(.gray)
                Text("от \(offer.price.value)$")
                    .foregroundStyle(.white)
            }
            .font(.subheadline)
        }
        .frame(width: 150)
    }
}


#Preview {
    CardView(offer: ConcertOffer(id: 1, title: "", town: "", price: Price(value: 123)))
}
