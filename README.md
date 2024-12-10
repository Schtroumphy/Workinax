# Workinax

A work clock in & out project

## 🌟 **Features** 🌟
- **Clock In**: User can clock in by click on 'Embaucher' in dashboard.
- **Clock Out**: User can clock out by click on 'Débaucher' when work as already start.
- **Take a break**: User can start a break time ans set up to 2 breaks in a day.
- **Entries historic**: User can see all entries he set.
.
.
.
- **Reactive State Management**: State management with **Riverpod** ensures reactive updates across the app.
- **Offline Persistence**: Local storage using **SQFlite** for data caching and offline capabilities.
- **Modular Design**: Clean Architecture enables modular and testable code.
- **Cross-Platform UI**: The app runs seamlessly on Android and iOS.

---
## 🖼️ Some captures

<p float="center">
  <img width="240" alt="image" src="https://github.com/user-attachments/assets/dea319a9-cc0c-4765-bcab-9681b361107d">

  <img width="240" alt="image" src="https://github.com/user-attachments/assets/d4d1c9bb-3e89-44cd-87e9-2ddc54972ad6">
  <img width="240" alt="image" src="https://github.com/user-attachments/assets/0d4967a1-c6ef-4891-9a70-0ae33b26c39f">
  <img width="240" alt="image" src="https://github.com/user-attachments/assets/9a6aa205-59ba-4505-9aab-d63e96cf5d48">

  <img width="240" alt="image" src="https://github.com/user-attachments/assets/bab392f6-3d4b-4108-afbc-92b2d0c16f40">
  <img width="240" alt="image" src="https://github.com/user-attachments/assets/1c820738-be12-45e9-bf0f-7fc23bfdb38e">
  <img width="240" alt="image" src="https://github.com/user-attachments/assets/7e3d8429-eb74-4c35-89f0-8448476ea8e1">

  <img width="240" alt="image" src="https://github.com/user-attachments/assets/a58bb28f-6e80-49c3-a239-a2e7fffa8b38">
</p>

---

## 🛠️ **Technologies Used**

### Flutter Framework
- **Dart**: Language used for the Flutter framework.
- **Flutter**: For building cross-platform UI.

### State Management
- **Riverpod Generator**: Used for state management with compile-time safety and code generation.

### Local Database
- **SQFlite**: Lightweight SQLite wrapper for local database storage.

### Architecture
- **Clean Architecture**:
  - Separation of concerns with layers: `Presentation`, `Domain`, and `Data`.
  - Decoupling business logic from UI and data sources.

---

## 🚀 **Getting Started**
### Prerequisites
Ensure you have the following installed:
- Flutter SDK (v3.24.5+)
- Dart (v3.5.4+)
- Android Studio / VS Code with Flutter plugin

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/Schtroumphy/Workinax.git
   cd Workinax
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```
   
3. Generate code:
   ```bash
   flutter pub run build_runner build -d
   ```
   
5. Run project
   ```bash
   flutter pub run
   ```
---

## 🗂️ **Project structure**
The project is structured based on **Clean Architecture** principles with additional folders for shared components and specific feature modules.

```plaintext
lib/
├── core/                 # Core functionalities shared across the app
│   ├── extensions/       # Custom extensions for Dart/Flutter types
│   ├── theme/            # App-wide themes and styling
│   ├── widgets/          # Common reusable widgets
│   └── utils.dart        # Shared utility functions
├── features/             # Features organized by domain
│   └── time_entry/       # Time Entry feature
│       ├── application/  # Application services, such as coordinators or orchestrators
│       ├── data/         # Data sources, repositories, and models
│       ├── domain/       # Entities and use cases
│       ├── presentation/ # UI components and state providers
│       └── widgets/      # Widgets specific to the Time Entry feature
├── main.dart             # Entry point of the application
```

## Modèle de données

![img.png](documentation/img.png)

---

## ☑️ Test coverage

__Generate & open coverage__

```shell script
$ flutter test --coverage
$ lcov --remove coverage/lcov.info 'lib/*/*.g.dart' 'lib/core/constants/*.dart' 'lib/theme/*.dart' -o coverage/lcov.info
$ genhtml coverage/lcov.info -o coverage/html
$ open coverage/html/index.html
```

## Backlog

- Add day off requests
- Statistic page filtered by month & week
