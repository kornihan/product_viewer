# Product Viewer App

## General information

The **Product Viewer** is a simple Flutter mobile application(tested on iOS and Android platforms) that contains two screens: product listing
screen and a product detail screen. The app fetches product data from the [Fake Store API](https://fakestoreapi.com/) and uses the BLoC for state management. The app also supports offline access through local data caching when there is no internet connection.

---

## Architecture

The app is built with the **BLoC architecture**, the project structure includes:
- **bloc**: Defines the blocs used in the project(currently, there is just ProductsBloc which has one event - fetch products data)
- **exceptions**: Defines custom exceptions that are used in app(like API exception or No-Internet exception).
- **models**: Defines different data models including those that represent API data as well as helper models used within the app
- **network**: Defines ApiClient class which implements different RESTful methods(for now it is just GET method).
- **presentation**: Defines all widgets that are used in app - screens, buttons, images etc.
- **repositories**: Defines the products repository responsible for fetching products and handling different errors, as well as 
the local DB(which is implemented using NoSQL Hive DB).


---

## Building and running the project

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/kornihan/product_viewer
2. Navigate to the project directory:
   ```bash
   cd product_viewer
3. Get dependencies:
   ```bash
   flutter pub get
4. Run the app:
   ```bash
   flutter run
5. Building the APK (Optional):
    If you want to generate an APK for installation on Android devices
   ```bash
   flutter build apk --release
### P.S.

Ensure you have installed Flutter SDK, a compatible code editor (like Visual Studio Code or Android Studio) and have a connected physical device or 
simulator/emulator. The app can be tested on simulators/emulators for both platforms - iOS and Android as well as on a real Android device. For test 
the app on real iOS device please contact me, so I can add you to development team.