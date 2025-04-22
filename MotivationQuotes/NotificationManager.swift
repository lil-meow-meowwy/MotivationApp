//
//  NotificationManager.swift
//  MotivationQuotes
//
//  Created by Kristina Yaroshenko on 22.04.2025.
//

import UserNotifications
import SwiftUI

class NotificationManager {
    static let instance = NotificationManager()

    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]

        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("Notification permission granted? \(success)")
            }
        }
    }

    func scheduleDailyNotification(at hour: Int, minute: Int, quote: String) {
        let content = UNMutableNotificationContent()
        content.title = "Your Daily Quote"
        content.body = quote
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
}
