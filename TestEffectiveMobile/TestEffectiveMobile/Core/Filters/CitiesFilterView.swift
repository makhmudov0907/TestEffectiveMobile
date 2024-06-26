//
//  CitiesFilterView.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 23/06/24.
//

import SwiftUI

struct CitiesFilterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var withoutTransfer = true
    @State private var withoutSeparateBooking = false
    @State private var withoutOvernightTransfer = false
    @State private var withoutChangingAirport = false
    
    //MARK: Для вывода списка названий Fonts
    /*
    init() {
        for familyName in UIFont.familyNames {
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("-- \(fontName)")
            }
        }
    }
    */
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.04705878347, green: 0.04705878347, blue: 0.04705878347, alpha: 1))
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                    }
                    .padding(.leading)
                    .padding(.trailing, 5)
                    Text("Фильтры")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(width: 328, height: 40)
                .background(Color(#colorLiteral(red: 0.140514493, green: 0.144960016, blue: 0.1623282433, alpha: 1)))
                .clipShape(.rect(cornerRadius: 10))
                .padding(.top, 20)
                
                Text("Популярные фильтры")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .medium))
                    .padding(.top, 20)
                
                HStack {
                    Text("Багаж включен")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color(#colorLiteral(red: 0.1837039888, green: 0.1880226433, blue: 0.2097533047, alpha: 1)))
                        .clipShape(.rect(cornerRadius: 20))
                    Text("Только прямые")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color(#colorLiteral(red: 0.1837039888, green: 0.1880226433, blue: 0.2097533047, alpha: 1)))
                        .clipShape(.rect(cornerRadius: 20))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .font(.custom("Times New Roman Italic", size: 16))
                .frame(width: 328, height: 51)
                .background(Color(#colorLiteral(red: 0.140514493, green: 0.144960016, blue: 0.1623282433, alpha: 1)))
                .clipShape(.rect(cornerRadius: 10))
                .padding(.top, 10)
                
                Text("Пересадки")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .medium))
                    .padding(.top, 20)
                VStack {
                    Toggle(isOn: $withoutTransfer) {
                        if withoutTransfer {
                            HStack {
                                Text("Без пересадок в странах, закрытых для туристов")
                                Spacer()
                                Image(systemName: "info.circle.fill")
                                    .font(.body)
                            }
                            .foregroundStyle(.white)
                        } else {
                            HStack {
                                Text("С пересадками в странах, закрытых для туристов")
                                Spacer()
                                Image(systemName: "info.circle.fill")
                                    .font(.body)
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    .tint(.blue)
                    .font(.system(size: 14))
                    
                    Toggle(isOn: $withoutSeparateBooking) {
                        if withoutSeparateBooking {
                            HStack {
                                Text("С раздельными бронированиями")
                                Spacer()
                                Image(systemName: "info.circle.fill")
                                    .font(.body)
                            }
                            .foregroundStyle(.white)
                        } else {
                            HStack {
                                Text("Без раздельных бронирований")
                                Spacer()
                                Image(systemName: "info.circle.fill")
                                    .font(.body)
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    .tint(.blue)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                    
                    Toggle(isOn: $withoutOvernightTransfer) {
                        if withoutOvernightTransfer {
                            Text("С ночной пересадкой")
                                .foregroundStyle(.white)
                        } else {
                            Text("Без ночной пересадки")
                                .foregroundStyle(.white)
                        }
                    }
                    .tint(.blue)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                    
                    Toggle(isOn: $withoutChangingAirport) {
                        if withoutChangingAirport {
                            Text("Со сменой аэропорта")
                                .foregroundStyle(.white)
                        } else {
                            Text("Без смены аэропорта")
                                .foregroundStyle(.white)
                        }
                    }
                    .tint(.blue)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                }
                .padding()
                .frame(width: 328, height: 218)
                .background(Color(#colorLiteral(red: 0.140514493, green: 0.144960016, blue: 0.1623282433, alpha: 1)))
                .clipShape(.rect(cornerRadius: 10))
                .padding(.top, 10)
                
                
                
                Spacer()
                
                NavigationLink {
                    TicketView().navigationBarBackButtonHidden()
                } label: {
                    Text("Показать билеты от 6 310$")
                        .font(.custom("Times New Roman Bold Italic", size: 18))
                        .foregroundStyle(.white)
                        .frame(width: 328, height: 48)
                        .background(Color(#colorLiteral(red: 0, green: 0.3554511666, blue: 0.06874644011, alpha: 1)))
                        .clipShape(.buttonBorder)
                }
                .padding(.bottom, 10)
            }
        }
        
        
    }
}

#Preview {
    NavigationStack {
        CitiesFilterView()
    }
}




