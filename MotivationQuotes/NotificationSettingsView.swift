//
//  NotificationSettingsView.swift
//  MotivationQuotes
//
//  Created by Kristina Yaroshenko on 22.04.2025.
//

import SwiftUI

struct NotificationSettingsView: View {
    @State private var selectedTime = Date()
    @State private var showConfirmation = false

    var body: some View {
        Form {
            Section(header: Text("Notification Time")) {
                DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
            }

            Button("Enable Daily Notification") {
                let components = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
                let hour = components.hour ?? 9
                let minute = components.minute ?? 0
                NotificationManager.instance.scheduleDailyNotification(
                    at: hour,
                    minute: minute,
                    quote: "Stay motivated! 💪"
                )
                showConfirmation = true
            }
            .alert(isPresented: $showConfirmation) {
                Alert(title: Text("✅ Scheduled"), message: Text("Daily quote set at \(formattedTime)"), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle("Notifications")
        .onAppear {
            NotificationManager.instance.requestAuthorization()
        }
    }

    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: selectedTime)
    }
}
