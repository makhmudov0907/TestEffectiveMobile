//
//  ContentView.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 21/06/24.
//

import SwiftUI

struct AviaTicketsView: View {
    @StateObject private var concertOffersViewModel = ConcertOffersViewModel()
    @StateObject private var ticketOfferViewModel = TicketOfferViewModel()
    
    @State private var departureCity: String = UserDefaultsManager.loadDepartureCity()
    @State private var arrivalCity: String = UserDefaultsManager.loadArrivalCity()
    
    @State private var priceSubscription = false
    @State private var animateHero = false
    //MARK: Для анимации кнопки xmark при клике на "Сложный маршрут" "Выходные" "Горящие билеты"
    @State private var animateButton = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.04705878347, green: 0.04705878347, blue: 0.04705878347, alpha: 1))
                    .ignoresSafeArea()
            
            VStack {
                if !animateHero {
                    Text("Поиск дешевых авиабилетов")
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .medium))
                        .frame(width: 172, height: 62)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                }
                
                HStack {
                    ZStack {
                        if animateHero {
                            Button {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    animateHero = false
                                }
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.white)
                                    .padding([.top, .trailing], 10)
                                    .scaleEffect(animateButton ? 1.2 : 1.0)
                                    .animation(.easeInOut(duration: 0.5), value: animateButton)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        }
                        
                        VStack {
                            HStack {
                                if !animateHero {
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            animateHero = true
                                        }
                                    } label: {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundStyle(.white.opacity(0.7))
                                    }
                                }
                                VStack(alignment: .leading, spacing: 10) {
                                    if animateHero {
                                        HStack(spacing: 10) {
                                            Image(systemName: departureCity.isEmpty ? "magnifyingglass" : "airplane.departure")
                                                .foregroundStyle(.white.opacity(0.7))
                                            CyrillicTextField(text: $departureCity, placeholder: "Откуда - Москва")
                                                .foregroundStyle(.white)
                                                .onChange(of: departureCity) { _, newValue in
                                                    UserDefaultsManager.saveDepartureCity(newValue)
                                                }
                                            if !departureCity.isEmpty && !arrivalCity.isEmpty {
                                                Button {
                                                    swap(&departureCity, &arrivalCity)
                                                } label: {
                                                    Image(systemName: "arrow.up.arrow.down")
                                                        .foregroundStyle(.gray)
                                                }
                                            } else if !departureCity.isEmpty {
                                                Button {
                                                    departureCity = ""
                                                } label: {
                                                    Image(systemName: "xmark")
                                                        .foregroundStyle(.gray)
                                                }
                                            }
                                        }
                                        
                                        Divider()
                                            .overlay(Color.white.opacity(0.7))
                                        
                                        HStack(spacing: 10) {
                                            Image(systemName: arrivalCity.isEmpty ? "magnifyingglass" : "airplane.arrival")
                                                .foregroundStyle(.white.opacity(0.7))
                                            CyrillicTextField(text: $arrivalCity, placeholder: "Куда - Турция")
                                                .foregroundStyle(.white.opacity(0.7))
                                                .onChange(of: arrivalCity) { _, newValue in
                                                    UserDefaultsManager.saveArrivalCity(newValue)
                                                }
                                            if !arrivalCity.isEmpty {
                                                Button {
                                                    arrivalCity = ""
                                                } label: {
                                                    Image(systemName: "xmark")
                                                        .foregroundStyle(.gray)
                                                }
                                            }
                                        }
                                    } else {
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                animateHero = true
                                            }
                                        } label: {
                                            if departureCity.isEmpty {
                                                Text("Откуда")
                                                    .foregroundColor(.white.opacity(0.7))
                                            } else {
                                                Text(departureCity)
                                                    .foregroundColor(.white.opacity(0.7))
                                            }
                                        }
                                        .foregroundStyle(.white)
                                        
                                        Divider()
                                            .overlay(Color.white.opacity(0.7))
                                        
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                animateHero = true
                                            }
                                        } label: {
                                            if arrivalCity.isEmpty {
                                                Text("Куда - Турция")
                                                    .foregroundColor(.white.opacity(0.7))
                                            } else {
                                                Text(arrivalCity)
                                                    .foregroundColor(.white.opacity(0.7))
                                            }
                                        }
                                        
                                    }
                                }
                                .padding(.leading, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            .frame(width: animateHero ? 328 : 296, height: animateHero ? 96 : 90)
                            .background(Color(#colorLiteral(red: 0.2424744964, green: 0.2469268441, blue: 0.2643190324, alpha: 1)))
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.top, animateHero ? 50 : 0)
                            
                            if animateHero && departureCity.isEmpty && arrivalCity.isEmpty {
                                sceneOne
                            } else if animateHero {
                                sceneTwo
                            }
                        }
                    }
                }
                .frame(width: animateHero ? UIScreen.main.bounds.width : 328, height: animateHero ? UIScreen.main.bounds.height - 50 : 122)
                .background(Color(#colorLiteral(red: 0.1837039888, green: 0.1880226433, blue: 0.2097533047, alpha: 1)))
                .clipShape(.rect(cornerRadius: 20))
                .padding(.top, animateHero ? 100 : 25)
                .animation(.easeInOut(duration: 0.5), value: animateHero)
                
                
                
                if !animateHero {
                    VStack {
                        if concertOffersViewModel.isLoading {
                            ProgressView()
                        } else if let errorMessage = concertOffersViewModel.errorMessage {
                            Text("Error: \(errorMessage)")
                        } else {
                            Text("Музыкально отлететь ")
                                .foregroundStyle(.white)
                                .font(.system(size: 22, weight: .medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.top, .leading], 25)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 30) {
                                    ForEach(concertOffersViewModel.concertOffers) { offer in
                                        CardView(offer: offer)
                                    }
                                }
                            }
                            .padding([.top, .leading], 10)
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        AviaTicketsView()
    }
}

extension AviaTicketsView {
    var sceneOne: some View {
        VStack {
            //MARK: Иконки
            HStack(alignment: .top, spacing: 10) {
                ForEach(routes) { route in
                    Button {
                        if route.title == "Куда угодно" {
                            arrivalCity = "Куда угодно"
                        } else {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                animateButton = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    animateButton = false
                                }
                            }
                        }
                    } label: {
                        VStack {
                            Image(route.imageName)
                            Text(route.title)
                                .font(.caption)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .frame(width: 75, height: 100)
                        .multilineTextAlignment(.center)
                    }
                }
            }
            .padding(.top, 20)
            //MARK: Города
            VStack(alignment: .leading, spacing: 20) {
                ForEach(destinations) { destination in
                    VStack(alignment: .leading) {
                        Button {
                            arrivalCity = destination.title
                        } label: {
                            HStack {
                                Image(destination.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(destination.title)
                                        .font(.system(size: 16, weight: .semibold))
                                    
                                    Text(destination.subtitle)
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundStyle(.gray)
                                }
                            }
                            .foregroundStyle(.white)
                        }
                        Divider()
                            .overlay(Color.white.opacity(0.7))
                    }
                }
            }
            .padding()
            .frame(width: 328, height: 216)
            .background(Color(.gray).opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 10)
            
            Spacer()
        }
        .transition(.opacity)
    }
    
    var sceneTwo: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("обратно")
                        }
                        .padding(5)
                        .background(Color(.gray).opacity(0.2))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "")
                            Text("24 фев, сб")
                        }
                        .padding(5)
                        .background(Color(.gray).opacity(0.2))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "person")
                            Text("1, эконом")
                        }
                        .padding(5)
                        .background(Color(.gray).opacity(0.2))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    NavigationLink {
                        TicketsFilterView().navigationBarBackButtonHidden()
                    } label: {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                        }
                        .padding(5)
                        .background(Color(.gray).opacity(0.2))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                }
                .font(.callout)
                .foregroundStyle(.white)
                .padding()
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("Прямые рельсы")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
                
                if ticketOfferViewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    ScrollView {
                        ForEach(Array(ticketOfferViewModel.ticketOffers.enumerated()), id: \.offset) { index, offer in
                            VStack {
                                HStack {
                                    Circle()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(ticketOfferViewModel.getColor(for: index))
                                    VStack(alignment: .leading, spacing: 3) {
                                        HStack {
                                            Text(offer.title)
                                                .foregroundStyle(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Button {
                                                //
                                            } label: {
                                                Text("\(offer.price.value)$ ⟩")
                                            }
                                            .frame(alignment: .trailing)
                                        }
                                        Text(offer.timeRange.joined(separator: " "))
                                            .foregroundStyle(.white)
                                            .lineLimit(1)
                                    }
                                    .font(.system(size: 14))
                                }
                                .padding(.vertical, 5)
                                Divider()
                                    .overlay(Color.white.opacity(0.7))
                            }
                        }
                    }
                    Button {
                        //
                    } label: {
                        Text("Показать все")
                    }
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
            .frame(width: 328, height: 288)
            .background(Color(#colorLiteral(red: 0.1129580364, green: 0.1176607981, blue: 0.1263159811, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            NavigationLink {
                SeeAllTicketsView(departureCity: departureCity, arrivalCity: arrivalCity)
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Посмотреть все билеты")
                    .foregroundStyle(.white)
                    .frame(width: 328, height: 42)
                    .background(.link)
                    .clipShape(.rect(cornerRadius: 10))
            }
            //MARK: Чтобы кнопка была неактивной пока не введут данные в поиск
            .opacity(departureCity.isEmpty || arrivalCity.isEmpty ? 0.5 : 1.0)
            .disabled(departureCity.isEmpty || arrivalCity.isEmpty)
            .padding(.top, 10)
            
            Toggle(isOn: $priceSubscription) {
                if priceSubscription {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundStyle(.blue)
                            .font(.title3)
                        Text("Отписка")
                    }
                    .padding()
                } else {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundStyle(.blue)
                            .font(.title3)
                        Text("Подписка на цену")
                    }
                    .padding()
                }
            }
            .tint(.blue)
            .padding(.trailing)
            .foregroundStyle(.white)
            .background(Color(#colorLiteral(red: 0.140514493, green: 0.144960016, blue: 0.1623282433, alpha: 1)))
            .clipShape(.rect(cornerRadius: 10))
            .frame(width: 328, height: 51)
            .padding(.top, 20)
            
            Spacer()
        }
        
    }
}
