//
//  SeeAllTicketsView.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 22/06/24.
//

import SwiftUI

struct SeeAllTicketsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var ticketViewModel = TicketViewModel()
    
    var departureCity: String
    var arrivalCity: String
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.04705878347, green: 0.04705878347, blue: 0.04705878347, alpha: 1))
                .ignoresSafeArea()
            
            VStack {
                header
                
                content
                    .overlay(
                        filterButton,
                        alignment: .bottom
                    )
                Spacer()
            }
        }
    }
    // Функция для задания текста меток
    private func labelText(for index: Int) -> String? {
        switch index {
        case 0: return "Самый удобный"
        case 1: return "Прилет вечером"
        default: return nil
        }
    }
    
    // Функция для задания отступов
    private func topPadding(for index: Int) -> CGFloat {
        switch index {
        case 0: return 30
        case 1: return 20
        default: return 10
        }
    }
}

#Preview {
    NavigationStack {
        SeeAllTicketsView(departureCity: "Москва", arrivalCity: "Турция")
    }
}

extension SeeAllTicketsView {
    var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.link)
            }
            .padding(.leading)
            .padding(.trailing, 5)
            VStack(alignment: .leading) {
                Text("\(departureCity) - \(arrivalCity)")
                    .foregroundStyle(.white)
                Text("23 февраля, 1 пассажир")
                    .foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: 328, height: 56)
        .background(Color(#colorLiteral(red: 0.140514493, green: 0.144960016, blue: 0.1623282433, alpha: 1)))
        .clipShape(.rect(cornerRadius: 10))
    }
    
    var content: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(ticketViewModel.tickets.indices, id: \.self) { index in
                    let ticket = ticketViewModel.tickets[index]
                    TicketCardView(
                        ticket: ticket,
                        ticketViewModel: ticketViewModel,
                        labelText: labelText(for: index),
                        topPadding: topPadding(for: index)
                    )
                }
            }
        }
    }
    var filterButton: some View {
            VStack {
                Spacer()
                HStack(spacing: 15) {
                    NavigationLink {
                        CitiesFilterView().navigationBarBackButtonHidden()
                    } label: {
                        HStack(spacing: 5) {
                            Image(systemName: "slider.horizontal.3")
                            Text("Фильтр")
                        }
                    }
                    Text("/")
                    NavigationLink {
                        
                    } label: {
                        HStack(spacing: 5) {
                            Image(systemName: "chart.bar.xaxis")
                            Text("График цен")
                        }
                    }
                    .disabled(true)
                }
                .padding()
                .background(.link)
                .foregroundColor(.white).bold()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.bottom, 10)
            }
        }
    
}

struct TicketCardView: View {
    let ticket: Ticket
    @ObservedObject var ticketViewModel: TicketViewModel
    
    // Параметры для отображения меток и отступов
    let labelText: String?
    let topPadding: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(ticket.price.value) $")
                .foregroundStyle(.white)
                .font(.system(size: 22, weight: .semibold))
                .padding(.leading, 10)
            
            HStack {
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.red) // Используем цвет из модели данных Ticket, можно изменить на dynamic binding
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        VStack(spacing: 5) {
                            Text(ticketViewModel.formatDateToTime(ticket.departure.date))
                                .foregroundStyle(.white)
                            Text(ticket.departure.airport)
                                .foregroundColor(.gray)
                        }
                        Text("-")
                            .foregroundStyle(.white)
                        VStack(spacing: 5) {
                            Text(ticketViewModel.formatDateToTime(ticket.arrival.date))
                                .foregroundStyle(.white)
                            Text(ticket.arrival.airport)
                                .foregroundColor(.gray)
                        }
                        //MARK: Через слэш отображается “Без пересадок”, если has_transfer = false. Иначе текст со слэшем не отображается.
                        if ticket.hasTransfer == false {
                            Text("\(ticketViewModel.calculateDuration(departure: ticket.departure.date, arrival: ticket.arrival.date)) / Без пересадок")
                                .foregroundStyle(.white)
                        } else {
                            Text("\(ticketViewModel.calculateDuration(departure: ticket.departure.date, arrival: ticket.arrival.date))")
                                .foregroundStyle(.white)
                        }
                        
                    }
                }
                .font(.system(size: 13, weight: .regular))
            }
            .padding(.leading, 10)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: 328, height: 117)
        .background(Color(#colorLiteral(red: 0.140514493, green: 0.144960016, blue: 0.1623282433, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.top, topPadding)
        .overlay(
            // Отображение метки, если она есть
            labelText.map { text in
                Text(text)
                    .frame(width: 126, height: 21)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .font(.system(size: 14))
                    .padding(.top, 10)
            },
            alignment: .topLeading
        )
    }
    
}

