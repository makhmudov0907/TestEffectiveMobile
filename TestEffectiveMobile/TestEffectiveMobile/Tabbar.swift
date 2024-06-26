//
//  Tabbar.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 21/06/24.
//

import SwiftUI

struct Tabbar: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
    }
    var body: some View {
        NavigationStack {
            TabView {
                AviaTicketsView()
                    .tabItem {
                        Label("Авиабилеты", systemImage: "airplane")
                    }
                
                RoundedRectangle(cornerRadius: 20)
                    .tabItem {
                        Label("Отели", systemImage: "bed.double")
                    }
                RoundedRectangle(cornerRadius: 20)
                    .tabItem {
                        Label("Короче", systemImage: "mappin")
                    }
                RoundedRectangle(cornerRadius: 20)
                    .tabItem {
                        Label("Подписки", systemImage: "bell")
                    }
                RoundedRectangle(cornerRadius: 20)
                    .tabItem {
                        Label("Профиль", systemImage: "person")
                    }
            }
            .tint(Color.blue)
        }
    }
}

#Preview {
    Tabbar()
}
