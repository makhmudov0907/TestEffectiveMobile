//
//  CyrillicTextField.swift
//  TestEffectiveMobile
//
//  Created by Mirshod Makhmudov on 24/06/24.
//

import SwiftUI

struct CyrillicTextField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        TextField(placeholder, text: $text)
            .onChange(of: text) { _, newValue in
                text = newValue.filter { $0.isCyrillic }
            }
    }
}

extension Character {
    var isCyrillic: Bool {
        return ("А"..."я").contains(self) || self == "ё" || self == "Ё"
    }
}

