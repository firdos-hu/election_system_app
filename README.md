# 🇪🇹 EthioVote – Flutter Mobile Voting App

## 📌 Project Overview

**EthioVote** is a Flutter-based mobile application designed to simulate a secure and region-based election system. The app allows users to register, log in, and vote for candidates within their assigned region, while administrators manage candidates and monitor results.

This project demonstrates key mobile development concepts including authentication, state management, local data handling, API integration, and device feature usage (location services).

---

## 🚀 Features

### 👤 User Features

* User registration and login
* Role-based authentication (Admin / Voter)
* Vote for candidates (only once)
* Region-based voting restriction
* View election results
* Live chart visualization of votes
* News feed integration (API-based)

---

### 🧑‍💼 Admin Features

* Secure admin login
* Add new candidates
* Delete candidates
* Reset votes
* View total users and votes
* View live voting charts

---

### 📍 Device Feature Integration

* Uses **Location Services (GPS)**
* Verifies user location before allowing voting
* Ensures users vote only within their registered region
* Handles:

    * Permission requests
    * Permission responses

---

## 🛠️ Technologies Used

* **Flutter (Dart)**
* Material UI
* Local Fake Database (In-Memory)
* HTTP API (for news)
* Geolocator & Geocoding plugins
* Android SDK

---

## 📂 Project Structure

```text
lib/
├── screens/        # UI screens (Login, Home, Vote, Admin, etc.)
├── services/       # Business logic (Auth, DB, Location, API)
├── models/         # Data models
├── widgets/        # Reusable UI components
├── utils/          # Helpers and constants
├── api/            # API services
```

---

## 🔐 Authentication System

* Single login screen for both users and admins
* Role-based redirection:

    * Admin → Admin Dashboard
    * User → Voting Dashboard
* Session handling implemented

---

## 🗳️ Voting Logic

* Each user can vote **only once**
* Votes are stored in a centralized data structure
* Candidates are filtered by region
* Voting is restricted based on:

    * User region
    * Real-time device location

---

## 📍 Location Validation

The app uses GPS to:

* Detect user's real location
* Compare with registered region
* Allow voting only if both match

---

## 🌐 API Integration

* Public API used to fetch dynamic news
* Displays election-related or general news
* Handles loading and error states

---

## ▶️ Demo Video

🔗 Add your demo video link here:
👉  https://www.loom.com/share/11f7486e84404cefaeb525d9548987d8

---

## 👥 Group Members

* 👤 Name 1 –Abinet Israel ID 0075/15
* 👤 Name 2 –Addis Negash ID 0090/15
* 👤 Name 3 –Dawit H/Mariyam ID 0299/15
* 👤 Name 4 –Firdos Kedir ID 0435/15
* 👤 Name 5 – Mickyas Alemshet ID 5755/15

*(Replace with your actual group members)*

---

## ⚙️ Setup Instructions

1. Clone the repository:

```bash
git clone https://github.com/your-username/ethiovote.git
```

2. Navigate to project folder:

```bash
cd ethiovote
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

---

## 📱 Requirements

* Android device or emulator
* Flutter SDK installed
* USB debugging enabled (for real device testing)

---

## ⚠️ Notes

* Location feature works best on **real devices**
* Emulator may require manual location setup
* Internet is required for API (news)

---

## 🎯 Project Objective

This project was developed as part of a **Mobile App Development course** to demonstrate:

* Flutter development skills
* UI/UX design
* Real-world feature integration
* Problem-solving and system design

---

## 📄 License

This project is for educational purposes only.

---

## ⭐ Acknowledgment

Special thanks to instructors and peers for guidance and support throughout the development process.

---