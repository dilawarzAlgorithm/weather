# WeatherPro 🌦️

A high-performance, location-aware weather application built with Flutter, focusing on clean architecture, modular design, and fluid user experiences.

## 🚀 Key Features

Multi-City Swipe Navigation: Uses a PageView.builder with page indicators to allow users to swipe seamlessly between saved locations.

## Dynamic Search & Management:

1. **Reorderable Lists:** Long-press to drag and drop cities to prioritize your view.

2. **Swipe-to-Delete:** Quickly remove locations using the Dismissible pattern.

3. **GPS Location Awareness:** One-tap weather fetching for your current location using the location package.

4. **Advanced Weather Metrics:** Real-time tracking of UV Index, Humidity, Precipitation, and Wind Speed using responsive Wrap layouts.

5. **Deep Data Insights:** Displays today's High (Max) and Low (Min) temperatures alongside "Feels Like" data.

## 🛠️ Tech Stack

1. Framework: Flutter (Material 3)

2. State Management: Riverpod (Notifier & StateProvider)

3. Networking: HTTP with JSON Serialization

4. Local Config: flutter_dotenv for secure API key management

5. Fonts: Google Fonts (Ubuntu Condensed)

6. Location Hardware: location package

## 📂 Getting Started

1. Prerequisites

- Flutter SDK installed

- A free API Key from WeatherAPI.com

2. Environment Setup

Create a folder named .env in your root directory and add a file named .env inside it:

```bash
BASE_URL=https://api.weatherapi.com/v1/forecast.json
WEATHER_API_KEY=your_api_key_here
```

3. Installation

```bash
#Clone the repository

git clone https://github.com/dilawarzAlgorithm/weather.git

# Install dependencies

flutter pub get

# Run the project

flutter run
```
