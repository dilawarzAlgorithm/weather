# WeatherPro 🌦️

A professional-grade, location-aware weather application built with Flutter. This app focuses on a clean user experience, horizontal swipe navigation, and persistent user preferences.

## 🚀 Key Features

- **Multi-City Swipe Navigation:** Effortlessly navigate through your saved locations using a `PageView` with smooth transitions and page indicators.

- **Persistent Storage:**
  - **Saved Locations:** Your city list is automatically saved to local storage and restored on app launch.

  - **User Settings:** Preferences for Temperature (Celsius/Fahrenheit) and Speed (Mph/Kph) units are remembered across sessions.

- **Dynamic Unit Switching:** Real-time conversion across the entire app when units are toggled in the Settings menu.

- **Smart Data Handling:**
  - **Auto-Sync:** Background synchronization ensures your weather data is fresh every time you open the app.

  - **Search & Management:** Add cities by name, reorder them with drag-and-drop, or swipe to delete.

- **GPS Integration:** One-tap weather fetching for your current physical location.

- **Clean UI Architecture:** Modern, minimal design using custom Google Fonts.

## 🛠️ Tech Stack

- **Framework:** Flutter

- **State Management:** Riverpod (Notifiers for reactive state)

- **Persistence:** `shared_preferences` (Local Disk Storage)

- **Networking:** HTTP for REST API integration

- **Configuration:** `flutter_dotenv` for secure environment variables

- **Typography:** Google Fonts (Ubuntu Condensed)

## 📂 Getting Started

1. Prerequisites
   - Flutter SDK installed

   - A free API Key from [WeatherApi.com](https://www.weatherapi.com/)

2. Environment Setup

Create a folder named `.env` in your root directory and add a file named `.env` inside it:

```bash
BASE_URL=https://api.weatherapi.com/v1/forecast.json
WEATHER_API_KEY=your_api_key_here
```

3. Installation

```bash
# Clone the repository
git clone https://github.com/dilawarzAlgorithm/weather.git

# Install dependencies
flutter pub get

# Run the project
flutter run
```

## 📱 Project Structure

- `lib/models`: Data structures and JSON serialization.

- `lib/provider`: Riverpod Notifiers and API Repository implementation.

- `lib/screens`: Primary UI views (Home, Search, Settings, Location).

- `lib/widgets`: Reusable UI components and layout helpers.

> Developed with a focus on Flutter best practices and scalable state management.
