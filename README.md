# GetIDExample

This repository contains an example of integration native GetID [iOS](https://github.com/vvorld/getid-ios-sdk) and [Android](https://github.com/vvorld/getid-android-sdk) SDKs into a Flutter cross-platform application.

## Setup
In order to start using GetID SDK, you will need an `SDK KEY` and `API URL`. Both can be found and modified either through your GetID admin panel or via contacting our [integration team](mailto:support@getid.ee).

Also, make sure that you've set up the [development environment](https://flutter.dev/docs/get-started/install).

Clone the project and navigate to the project directory:
```bash
git clone https://github.com/vvorld/getid-flutter-example
cd getid-flutter-example
```

Open `lib/main.dart` file and set `apiURL` and `sdkKey`.

### iOS
```bash
cd ios
pod install
```
Then just type `flutter run` in the root project directory.

### Android
Just type `flutter run` in the root project directory.