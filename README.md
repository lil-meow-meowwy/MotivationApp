#  Motivational Quote App

A simple SwiftUI iOS app that delivers inspiring quotes to keep you going every day.
Includes font customization, daily notifications, favorites, and sharing features.

---

## Features

- **Random Motivational Quotes** – fetched from an open quote API.
- **Save Favorites** – keep the ones that matter most.
- **Share Quotes** – send inspiration to friends and social media.
- **Custom Font & Size** – choose from multiple fonts and adjust text size.
- **Dark Mode Support** – automatically adapts to your system theme.
- **Daily Notifications** – receive a quote at your chosen time.
- **Persistence** – favorites and settings are saved locally.

---

## Built With

- `SwiftUI` – declarative UI for building beautiful iOS interfaces.
- `UserDefaults` – for saving user settings and favorites.
- `URLSession` – for fetching data from a public API.
- `UNUserNotificationCenter` – for local notifications.
- `UIKit` (via `UIViewControllerRepresentable`) – for sharing quotes.

---

## How to Run

1. Clone the repo:
   ```bash
   git clone https://github.com/lil-meow-meowwy/motivation-quote-app.git
   ```

2. Open in Xcode:
   ```bash
   open MotivationQuoteApp.xcodeproj
   ```

3. Run on a simulator or your device.

---

## Permissions

- Notification permission is requested on app launch.
- No data is tracked or sent externally — it's fully local and privacy-friendly.

---

## API Used

Quotes are fetched from:
**[https://zenquotes.io/api/random](https://zenquotes.io/api/random)**  
Free and open-source for inspirational content.

---

---

##  License

MIT License. Use, remix, and spread the motivation.

---

## Contributions

PRs are welcome! If you have ideas for features or improvements, feel free to open an issue or contribute.

---
