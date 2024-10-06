# the_weather


## Android APK download link

https://drive.google.com/drive/u/1/folders/1qJqbQPhbFLMwHo4HitPlXVVNq-IfHWQd

## Contents

1. [Setting Up](#setting-up-flutter)
2. [Run The App](#run-the-app)

Before running the app, please follow the steps to verify your environment

## Setting Up Flutter

Follow the instructions in official docs to install necessary tools for your preferred IDE
https://docs.flutter.dev/get-started/install

### Environment variables

To run the app or test locally, we need to configure the list of environment variables.
You can try to copy the `.env-test` file to `.env` if it has not yet been done:

```
> cp .env-test .env
```
Update the api-key accordingly.

### Run the app

To run the app

```
> flutter clean (Do this when you think your pub packages are mess)
> flutter pub cache clean (Do this when you think your pub packages are mess)
> flutter pub get
Running "flutter pub get" in escooter-mini-app...
> dart run build_runner build --delete-conflicting-outputs
> # Run the simulator or connect a physical device before you run the app
> flutter run --flavor local [for android]
> flutter run [for ios]
 or run with vscode (cmd + shift + P) -> Run flutter
```
