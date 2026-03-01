# 📱 Flutter GitHub API App

A Flutter application that allows users to search GitHub users and explore their repositories.

---

## Demo

<p align="center">
  <img src="assets/demo/app_demo.gif" width="350">
</p>

---

## Features

### User Search

- Search GitHub users by keyword
- Debounced search input
- Infinite scroll pagination
- Loading shimmer effect

### User Details

- Profile image
- Username
- Full name
- Followers & following count
- User repositories (excluding forked repositories)
- Repository language indicator
- Star count
- Open repository in custom tabs

---

## Folder Structure

```
lib
├── app
│   └── router
│
├── core
│   ├── api
│   ├── constants
│   └── utils
│
├── features
│   └── users
│       ├── data
│       │   ├── models
│       │   └── impl-repositories
│       │
│       ├── domain
│       │   ├── entities
│       │   └── repositories
│       │
│       └── presentation
│           ├── bloc
│           ├── screens
│           └── widgets
│               └── shimmers
│
└── main.dart
```

---

## API

Uses GitHub REST API:

- `GET /search/users`
- `GET /users/{username}`
- `GET /users/{username}/repos`

---

## Getting Started

### 1. Prerequisites

Make sure you have:

- Flutter (latest stable version)
- Dart SDK
- Android Studio or VS Code
- Android Emulator / iOS Simulator
- Git

Check Flutter installation:

```bash
flutter --version
```

---

### 2. Clone the Repository

```bash
git clone https://github.com/abhinav-sorate/flutter_github_api.git
cd flutter_github_api
```

---

### 3. Install Dependencies

```bash
flutter pub get
```

---

### 4. Setup GitHub Personal Access Token

GitHub API rate limit without authentication is **60 requests/hour** (that's why debounce time is 1 second.)  
This app requires a Personal Access Token.

#### Create a Token

1. Go to **GitHub → Settings**
2. Navigate to **Developer Settings**
3. Open **Personal Access Tokens**
4. Click **Generate new token (Classic)**
5. No special scopes required for public data

---

#### Create a `.env` File

Create a `.env` file in the root of the project:

```
GITHUB_TOKEN=your_personal_access_token_here
```

Make sure `.env` is added to `.gitignore`.

---

### 5. Run the Application

```bash
flutter run
```

---

### 6. Build for Release

Android:

```bash
flutter build apk
```

iOS:

```bash
flutter build ios
```

---
