# album_cover_craft

A Flutter app that simplifies the process of adding cover art to your music files using ffmpeg.
(This is only the main fonctionality of the app, maybe the next step is to add a music player 🤔😆).

## Disclaimer 😆

This project serves as a test for various aspects, including the configuration of Fastlane and the utilization of Dart define for environment variables used inside the Android folder. I'm trying to find a way to dynamically use the applicationId of the app variable when running the app, such as passing it as a variable through the run command without impacting the underlying codebase. 🤔

## Launch the project

Use dart define to replace the app label 

### Launch config in .vscode

```json
{
    //launch.json
    "configurations": [
        {
            "name": "cover craft (debug mode)",
            "request": "launch",
            "type": "dart",
            "toolArgs": [
                "--dart-define",
                "APPLICATION_LABEL=Your App Label"
            ] 
        },
    ]
}    
```

### Using terminal

```bash
flutter run --dart-define APPLICATION_LABEL="Your App Label"
```