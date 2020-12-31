//
//  KeyboardAdaptive..swift
//  turmeric
//
//  Created by sriram palapudi on 11/22/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//
//
//  KeyboardAdaptive.swift
//  KeyboardAvoidanceSwiftUI
//
//  Created by Vadim Bulavin on 3/27/20.
//  Copyright © 2020 Vadim Bulavin. All rights reserved.
//

import SwiftUI
import Combine

/// Note that the `KeyboardAdaptive` modifier wraps your view in a `GeometryReader`,
/// which attempts to fill all the available space, potentially increasing content view size.
struct KeyboardAdaptive: ViewModifier {
    @State private var bottomPadding: CGFloat = 0

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.bottomPadding)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
                    let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                    self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom + 100)
                    print("ft : \(keyboardHeight) : \(focusedTextInputBottom) - \(keyboardTop) - \(geometry.safeAreaInsets.bottom)")
            }
            .animation(.easeOut(duration: 0.16))
        }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}

