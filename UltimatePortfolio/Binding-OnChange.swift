//
//  Binding-OnChange.swift
//  UltimatePortfolio
//
//  Created by Alejandro Mendoza on 24/11/21.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            })
    }
}
