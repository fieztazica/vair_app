<br/>
<p align="center">
  <a href="https://github.com/fiezt1492/vair_app">
    <img src="assets/img/Icon-96.png" alt="Logo">
  </a>

  <h3 align="center">Vair App</h3>

  <p align="center">
    A mobile app of multiplatform software distribution system.
    <br/>
    <br/>
  </p>
</p>

![Contributors](https://img.shields.io/github/contributors/fiezt1492/vair_app?color=dark-green) ![Issues](https://img.shields.io/github/issues/fiezt1492/vair_app)

## Table Of Contents

* [About the Project](#about-the-project)
* [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Installation](#installation)
* [Contributing](#contributing)
* [License](#license)
* [Authors](#authors)
* [Acknowledgements](#acknowledgements)

## About The Project

![Screen Shot](images/screenshot.png)

Vair App is a Flutter-based mobile application designed to provide Android users with a seamless experience for discovering and downloading various applications. It serves as the client interface for a comprehensive software distribution system, allowing users to explore, install, and manage apps effortlessly.

## Built With

Vair App is built with the following Flutter dependencies, contributing to its functionality and user experience:

* GetX: A state management library that simplifies and enhances Flutter app development by providing a powerful combination of reactive programming, dependency injection, and state management.

* open_filex: A Flutter plugin that facilitates the opening of files with their default applications. In Vair App, it is utilized for the seamless installation of downloaded APK files.

* flutter_downloader: A plugin for handling file downloads in Flutter applications. Vair App employs this dependency to manage the downloading of application installation files.

* installed_apps: A Flutter plugin that allows the retrieval of information about installed applications on a device. This is used in Vair App to gather details about apps already installed on the user's device.

* cached_network_image: An efficient Flutter library for loading and caching images from network URLs. Vair App utilizes this dependency to enhance the performance of image loading.

* http: A package for making HTTP requests in Flutter. Vair App utilizes this to communicate with the vair_strapi CMS and vair_express server to fetch data and download application files.

* path_provider: A Flutter plugin that provides a platform-independent way to access the device's file system. In Vair App, it is used to obtain the download path for saving application installation files.

* shared_preferences: A Flutter plugin for reading and writing simple key-value pairs to persistent storage. Vair App uses this to store and retrieve user preferences.

These dependencies work cohesively to create a robust and feature-rich application, providing users with a seamless experience in discovering, downloading, and managing applications.

## Getting Started

To start using Vair App, follow these steps:

### Installation



1. Clone the repository: `git clone https://github.com/fiezt1492/vair_app.git`

2. Install dependencies using Flutter: `flutter pub get`

3. Run the app on an Android device or emulator: `flutter run`

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.
* If you have suggestions for adding or removing projects, feel free to [open an issue](https://github.com/fiezt1492/vair_app/issues/new) to discuss it, or directly create a pull request after you edit the *README.md* file with necessary changes.
* Please make sure you check your spelling and grammar.
* Create individual PR for each suggestion.

### Creating A Pull Request

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See [LICENSE](https://github.com/fiezt1492/vair_app/blob/main/LICENSE.md) for more information.

## Authors

* **Dat Hoang** - *Software Engineer Student* - [Dat Hoang](https://github.com/fiezt1492/)
* **Truong Huynh** - *Software Engineer Student* - [Truong Huynh](https://github.com/Schjr46/)

## Acknowledgements

* [JsonToDart](https://javiercbk.github.io/json_to_dart/)
* [GetX](https://pub.dev/packages/get)
