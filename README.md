# Flutter NewsApp

Flutter NewsApp is a news application built using Flutter, fetching real-time news articles from [newsapi.org](https://newsapi.org/). The app allows users to browse news by categories, view detailed articles, and bookmark articles for offline reading. It integrates state management, and offline storage for a seamless user experience.

## Features

- **Latest News:** Browse the latest news articles fetched from the NewsAPI.
- **Multiple Sources:** Read news articles from multiple sources or agencies.
- **Category-Based News:** Access news articles filtered by categories such as technology, sports, and health.
- **Bookmarking:** Bookmark articles to read later, even when offline, using Hive for local storage.
- **Offline Access:** View bookmarked articles without an internet connection.
- **State Management:** Efficient state management using `Provider` for better performance.
- **Future Updates:**
  - Search functionality to find specific articles.
  - Enhanced user settings and preferences for personalized news feeds.

## Backend

The news data is fetched from [newsapi.org](https://newsapi.org/) via API calls. No custom backend is used for this project.

## Getting Started

### Prerequisites

- Flutter SDK
- Android Studio/VS Code
- An API key from [NewsAPI](https://newsapi.org/)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/YourGitHubUsername/news_app.git
2. Navigate to the project directory:
   ```bash
   cd street_mart
3. Get dependencies:
   ```bash
   flutter pub get
5. Configure the API server URL in your app’s environment.
6. Run the app:
   ```bash
   flutter run

