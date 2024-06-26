//
//  DB.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 22/06/24.
//

import Foundation

struct Route: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
}
let routes = [
    Route(imageName: "1", title: "Сложный маршрут"),
    Route(imageName: "2", title: "Куда угодно"),
    Route(imageName: "3", title: "Выходные"),
    Route(imageName: "4", title: "Горячие билеты")
]

struct Destination: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
}
let destinations = [
    Destination(imageName: "bg6", title: "Стамбул", subtitle: "Популярное направление"),
    Destination(imageName: "bg8", title: "Сочи", subtitle: "Популярное направление"),
    Destination(imageName: "bg7", title: "Пхукет", subtitle: "Популярное направление")
]

