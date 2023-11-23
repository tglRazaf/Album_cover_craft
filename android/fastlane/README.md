fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android test

```sh
[bundle exec] fastlane android test
```

Runs all the tests

### android beta

```sh
[bundle exec] fastlane android beta
```

Submit a new Beta Build to Crashlytics Beta

### android deploy

```sh
[bundle exec] fastlane android deploy
```

Deploy a new version to the Google Play

### android uninstall_app

```sh
[bundle exec] fastlane android uninstall_app
```

Uninstall app

### android change_app_name

```sh
[bundle exec] fastlane android change_app_name
```

Change app name

### android change_package_app_name

```sh
[bundle exec] fastlane android change_package_app_name
```

Change app package name

### android configure_firebase

```sh
[bundle exec] fastlane android configure_firebase
```

Configure firebase

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
