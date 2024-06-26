//
//  TicketsFilterView.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 23/06/24.
//

import SwiftUI

struct TicketsFilterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showTransfer = true
    @State private var showBaggage = true
    @State private var numberOfTransfers: Double = 2
    @State private var numberOfBaggage: Double = 0
    
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
                
                Text("Пересадки")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .medium))
                    .padding(.top, 20)
                
                VStack {
                    Toggle(isOn: $showTransfer) {
                        if showTransfer {
                            Text("Без пересадок")
                        } else {
                            Text("С пересадками")
                        }
                    }
                    .tint(.blue)
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    Spacer()
                }
                .padding()
                .frame(width: 328, height: 141)
                .background(Color(#colorLiteral(red: 0.140514493, green: 0.144960016, blue: 0.1623282433, alpha: 1)))
                .clipShape(.rect(cornerRadius: 10))
                .padding(.top, 10)
                
                VStack {
                    Toggle(isOn: $showBaggage) {
                        if showBaggage {
                            Text("Только с багажом")
                        } else {
                            Text("Без багажа")
                        }
                    }
                    .tint(.blue)
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                }
                .padding()
                .frame(width: 328, height: 51)
                .background(Color(#colorLiteral(red: 0.140514493, green: 0.144960016, blue: 0.1623282433, alpha: 1)))
                .clipShape(.rect(cornerRadius: 10))
                .padding(.top, 10)
                
                VStack {
                    VStack {
                        HStack {
                            Text("Количество пересадок")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.leading, 30)
                            Text("до 2")
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(Color(.gray).opacity(0.5))
                                .clipShape(.rect(cornerRadius: 20))
                                .frame(alignment: .trailing)
                        }
                        .foregroundStyle(.white)
                        .font(.custom("Times New Roman Bold Italic", size: 16))
                        
                        HStack {
                            Text("0")
                                .foregroundStyle(.white)
                            
                            ZStack {
                                CustomSlider(
                                    value: $numberOfTransfers,
                                    range: 0...2,
                                    step: 1,
                                    thumbSize: CGSize(width: 30, height: 30),
                                    thumbColor: .white
                                )
                                .padding(.horizontal)
                                
                                HStack {
                                    Spacer()
                                    
                                    ForEach(1..<2, id: \.self) { index in
                                        if Double(index) != numberOfTransfers {
                                            Text("1")
                                                .foregroundStyle(.white)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Spacer().frame(maxWidth: .infinity)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                            }
                            
                            Text("2")
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal)
                    }
                    
                    VStack {
                        Text("Длительность пересадок")
                            .foregroundStyle(.white)
                            .font(.custom("Times New Roman Bold Italic", size: 16))
                        
                        Slider(value: $numberOfBaggage, in: 0...24, step: 4) {
                            
                        } minimumValueLabel: {
                            Text("0")
                                .foregroundStyle(.white)
                        } maximumValueLabel: {
                            Text("24")
                                .foregroundStyle(.white)
                        }
                        Text("\(Int(numberOfBaggage))")
                            .foregroundStyle(.white)
                        
                    }
                }
                .padding()
                .frame(width: 328, height: 179)
                .background(Color(#colorLiteral(red: 0.140514493, green: 0.144960016, blue: 0.1623282433, alpha: 1)))
                .clipShape(.rect(cornerRadius: 10))
                .padding(.top, 10)
                
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Готово")
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
    TicketsFilterView()
}

//MARK: Custom Slider
struct CustomSlider: UIViewRepresentable {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var step: Double
    var thumbSize: CGSize
    var thumbColor: UIColor

    class Coordinator: NSObject {
        var parent: CustomSlider

        init(parent: CustomSlider) {
            self.parent = parent
        }

        @objc func valueChanged(_ sender: UISlider) {
            let stepValue = round(Double(sender.value) / parent.step) * parent.step
            parent.value = stepValue
            sender.value = Float(stepValue)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.minimumValue = Float(range.lowerBound)
        slider.maximumValue = Float(range.upperBound)
        slider.value = Float(value)
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)
        
        let thumbImage = UIImage(systemName: "circle.fill")?.withTintColor(thumbColor, renderingMode: .alwaysOriginal)
        UIGraphicsBeginImageContextWithOptions(thumbSize, false, 0.0)
        thumbImage?.draw(in: CGRect(origin: .zero, size: thumbSize))
        let resizedThumbImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        slider.setThumbImage(resizedThumbImage, for: .normal)
        
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }
}
