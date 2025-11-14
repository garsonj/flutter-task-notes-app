# Task Notes Manager

## Student Info
- Name: Garanga John
- Student Number: 2300722975
- Registration No.: 23/X/22975/PS

## Description
Simple Flutter app to create, edit, delete, and list task/note items.  
Features:
- Add / edit / delete tasks (title, description, priority, completion status)
- Persistent storage using SQLite (sqflite + sqflite_common_ffi for desktop)
- Theme toggle (light/dark) persisted with SharedPreferences
- Desktop (Windows) initialization handled for sqflite FFI

## Tech Stack
- Flutter
- sqflite + sqflite_common_ffi
- shared_preferences
- path_provider

## Running the Project
1. Clone the repository:
   ```sh
   git clone https://github.com/garsonj/flutter-task-notes-app.git
   cd flutter-task-notes-app
   ```
2. Fetch dependencies:
   ```sh
   flutter pub get
   ```
3. (Optional) Clean build artifacts:
   ```sh
   flutter clean
   flutter pub get
   ```
4. Run (Windows example):
   ```sh
   flutter run -d windows
   ```
5. For mobile:
   ```sh
   flutter run
   ```

## Project Structure (key files)
- lib/main.dart (theme + app bootstrap)
- lib/models/task_item.dart (data model + JSON)
- lib/data/database_helper.dart (SQLite helper)
- lib/screens/home_screen.dart (list + theme switch)
- lib/screens/screen2_screen.dart (add/edit form)

## Notes
- On desktop, sqflite FFI is initialized in main.dart.
- Use small, descriptive Git commits (e.g., "add model", "add db helper", "implement edit/delete").
