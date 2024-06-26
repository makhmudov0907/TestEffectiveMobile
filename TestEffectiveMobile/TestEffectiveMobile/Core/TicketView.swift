//
//  TicketView.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 23/06/24.
//

import SwiftUI

struct TicketView: View {
    @Environment(\.dismiss) var dismiss
    @State private var addBaggage = true
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.04705878347, green: 0.04705878347, blue: 0.04705878347, alpha: 1))
                    .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing, 10)
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal, 30)
                .font(.title2)
                .padding(.top, 20)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Дешевый тариф")
                            .foregroundStyle(.white)
                        
                        HStack {
                            Label("Ручная кладб 1x5 кг", systemImage: "checkmark.circle")
                                .foregroundStyle(.white)
                            Text("55x20x40 см")
                                .foregroundStyle(.gray)
                        }
                        .padding(.top, 10)
                        
                        Label("Без багажа", systemImage: "xmark")
                            .foregroundStyle(.white)
                            .padding(.top, 2)
                        
                        HStack {
                            Label("Обмен платный", systemImage: "checkmark.circle")
                            Image(systemName: "info.circle.fill")
                        }
                        .foregroundStyle(.white)
                        .padding(.top, 2)
                        HStack {
                            Label("Без возврата", systemImage: "xmark")
                            Image(systemName: "info.circle.fill")
                        }
                        .foregroundStyle(.white)
                        .padding(.top, 2)
                        
                        VStack {
                            HStack {
                                Toggle(isOn: $addBaggage) {
                                    if addBaggage {
                                        HStack {
                                            Text("Добавить багаж")
                                                .foregroundStyle(.white)
                                            Text("+ 1 082 $")
                                                .foregroundStyle(.blue)
                                        }
                                    } else {
                                        Text("Без багажа")
                                            .foregroundStyle(.white)
                                    }
                                }
                                .tint(.blue)
                                .font(.system(size: 16))
                            }
                            .padding(.horizontal)
                            
                            Divider()
                                .overlay(Color.white.opacity(0.7))
                            Button {
                                
                            } label: {
                                HStack {
                                    Text("Изменить обмен или возврат ")
                                        .foregroundStyle(.white)
                                    Text("⟩")
                                        .fontWeight(.bold)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal)
                            .padding(.top, 4)
                        }
                        .frame(width: 312, height: 102)
                        .background(Color(.gray).opacity(0.5))
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.top, 10)
                        
                    }
                    .frame(width: 338, height: 310)
                    .background(Color(.gray).opacity(0.5))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.top, 20)
                    
                    Text("Москва-Сочи")
                        .foregroundStyle(.white)
                    Text("04ч в пути")
                        .foregroundStyle(.gray)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 32, height: 32)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Якутия")
                                    .foregroundStyle(.white)
                                Text("04ч в полете")
                                    .foregroundStyle(.gray)
                            }
                            .font(.custom("SFProDisplay-RegularItalic", size: 14))
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Подробнее")
                                    .font(.custom("SFProDisplay-RegularItalic", size: 14))
                                    .foregroundStyle(.white)
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .background(Color(.gray).opacity(0.5))
                            .clipShape(.rect(cornerRadius: 20))
                        }
                        
                        //MARK: FlightsRowView
                        VStack(alignment: .leading) {
                            ForEach(flights) { flight in
                                FlightsRowView(time: flight.time, date: flight.date, city: flight.city, airport: flight.airport)
                                    .background(alignment: .leading) {
                                        if flights.last?.id != flight.id {
                                            Rectangle()
                                                .frame(width: 2)
                                                .offset(x: 7)
                                                .padding(.bottom, -10)
                                        }
                                    }
                            }
                        }
                        .padding([.leading, .top], 10)
                        .padding(.top, 10)
                        
                    }
                    .padding(.horizontal)
                    .frame(width: 338, height: 184)
                    .background(Color(.gray).opacity(0.5))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.top, 10)
                    
                    
                    HStack(spacing: 10) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 32, height: 32)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("6 310$")
                                .font(.custom("SFProDisplay-Regular", size: 20))
                            Text("На сайте Купибилет")
                                .font(.custom("SFProDisplay-Regular", size: 14))
                        }
                        .foregroundStyle(.white)
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Купить")
                                .foregroundStyle(.white)
                                .font(.custom("SFProDisplay-Regular", size: 16))
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(.pink)
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    .padding(.horizontal)
                    .frame(width: 338, height: 84)
                    .background(Color(.gray).opacity(0.5))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.top, 10)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    TicketView()
}
