# compsci279r-hw2

## How to open hosted version

Navigate to https://keller-mark.github.io/compsci279r-hw2/ in a web browser.

## How to open locally

1. Install [flutter](https://docs.flutter.dev/get-started/install) and add to `PATH`

2. Run the app

```sh
flutter run -d chrome
```

## Deployment

Run

```sh
flutter build web --base-href "/compsci279r-hw2/"
```

then commit the updated `build/web/` directory to the repository, then wait for GitHub action to push to GitHub pages.

## Resources

I used the following resources to learn Dart/Flutter and build the app.

- [Building a web application with Flutter](https://docs.flutter.dev/get-started/web)
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [learnxinyminutes where X=dart](https://learnxinyminutes.com/docs/dart/)
- [flutter_todo_app](https://github.com/AgweBryan/flutter_todo_app)
- https://api.flutter.dev/flutter/material/Checkbox-class.html
- https://api.flutter.dev/flutter/material/CheckboxListTile-class.html
- https://api.flutter.dev/flutter/widgets/Row-class.html
- https://api.flutter.dev/flutter/material/TextField-class.html
- https://api.flutter.dev/flutter/material/TextButton-class.html
- https://docs.flutter.dev/deployment/web#building-the-app-for-release
- https://stackoverflow.com/a/70569333