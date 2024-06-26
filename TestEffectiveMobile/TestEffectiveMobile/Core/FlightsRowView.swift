//
//  FlightsRowView.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 23/06/24.
//

import SwiftUI

struct Flight: Identifiable {
    let id = UUID()
    let time: String
    let date: String
    let city: String
    let airport: String
}
let flights = [
    Flight(time: "03:15", date: "23 фев, ср", city: "Москва", airport: "Внуково, VKO"),
    Flight(time: "07:10", date: "23 фев, ср", city: "Сочи", airport: "Адлер, AER")
]

struct FlightsRowView: View {
    let time: String
    let date: String
    let city: String
    let airport: String

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .fill(.black)
                .frame(width: 8, height: 8)
                .padding(4)
                .background(.gray.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
            VStack(alignment: .leading) {
                Text(time)
                    .foregroundStyle(.white)
                Text(date)
                    .foregroundStyle(.gray)
            }
            .font(.custom("SFProDisplay-RegularItalic", size: 14))
            VStack(alignment: .leading) {
                Text(city)
                    .foregroundStyle(.white)
                Text(airport)
                    .foregroundStyle(.gray)
            }
            .font(.custom("SFProDisplay-RegularItalic", size: 14))
        }
    }
}


#Preview {
    FlightsRowView(time: "", date: "", city: "", airport: "")
}
