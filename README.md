# Netflix Clone

A Netflix clone application built using Flutter, replicating the core features of Netflix with a focus on performance, clean architecture, and modern design principles.

## Features

- **User Authentication**: User login and registration using Firebase Authentication.
- **Movie and TV Show Browsing**: Browse movies and TV shows using data fetched from external APIs.
- **Search Functionality**: Search for movies and TV shows with separate results for each.
- **Movie/TV Show Details**: View detailed information about each movie or TV show, including trailers.
- **User Profile Management**: Manage user profiles and watchlists using Firebase Firestore.
- **Offline Caching**: Cached network images to reduce data usage and improve performance.
- **Smooth Animations**: Enhance user experience with Lottie animations and shimmer effects.

## Technologies and Dependencies

- **[Flutter](https://flutter.dev/)**: The UI toolkit used for building the application.
- **[Provider](https://pub.dev/packages/provider)**: State management solution for managing the app's state.
- **API Fetching**: 
  - **[dio](https://pub.dev/packages/dio)**: Powerful HTTP client for Dart.
  - **[http](https://pub.dev/packages/http)**: Simplified HTTP requests.
- **Models**: Data models to structure and manage API data.
- **[Firebase Firestore](https://firebase.google.com/products/firestore)**: A NoSQL cloud database to store user data and watchlists.
- **[FirebaseAuth](https://firebase.google.com/products/auth)**: For handling user authentication.
- **[GoRouter](https://pub.dev/packages/go_router)**: For declarative navigation and routing within the app.
- **[Shimmer](https://pub.dev/packages/shimmer)**: To show loading indicators for content that is still being fetched.
- **[Lottie](https://pub.dev/packages/lottie)**: For smooth and customizable animations.
- **[Cached Network Images](https://pub.dev/packages/cached_network_image)**: For efficient image loading and caching.
- **[YouTube Player Flutter](https://pub.dev/packages/youtube_player_flutter)**: For playing YouTube videos within the app.
- **[Video Player](https://pub.dev/packages/video_player)**: For playing video content.
- **[Google Fonts](https://pub.dev/packages/google_fonts)**: Custom fonts from Google Fonts.
- **[Smooth Page Indicator](https://pub.dev/packages/smooth_page_indicator)**: For creating smooth and customizable page indicators.
- **[Cupertino Icons](https://pub.dev/packages/cupertino_icons)**: iOS-style icons.
- **[URL Launcher](https://pub.dev/packages/url_launcher)**: For launching URLs in the browser or other apps.
- **[Lucide Icons](https://pub.dev/packages/lucide_icons)**: A set of open-source icons.
- **[Intl](https://pub.dev/packages/intl)**: For internationalization and localization.
- **[Transitioned Indexed Stack](https://pub.dev/packages/transitioned_indexed_stack)**: For smooth transitions between stacked widgets.

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/netflix_clone.git
   cd netflix_clone
