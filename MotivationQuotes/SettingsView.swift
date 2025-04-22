//
//  SettingsView.swift
//  MotivationQuotes
//
//  Created by Kristina Yaroshenko on 22.04.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("fontSize") var fontSize: Double = 18
    @AppStorage("fontName") var fontName: String = "System"

    let availableFonts = ["System", "Georgia", "Courier", "Helvetica Neue", "Times New Roman"]

    var body: some View {
        Form {
            Section(header: Text("Font Size")) {
                Slider(value: $fontSize, in: 12...30, step: 1) {
                    Text("Font Size")
                }
                Text("Selected Size: \(Int(fontSize))")
            }

            Section(header: Text("Font Family")) {
                Picker("Font", selection: $fontName) {
                    ForEach(availableFonts, id: \.self) { font in
                        Text(font)
                            .font(font == "System" ? .body : .custom(font, size: 16))
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
        }
        .navigationTitle("Settings")
    }
}
