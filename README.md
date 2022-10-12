# Jury Marks

Flutter project for managing jury marks in `Google Sheets` using web application created with `Google Apps Script`. State management is handled by `Provider` and `dio` package is used for making http requests.

## Content table

- [Configuration](#configuration)
  - [Build flutter app](#flutter-app)
  - [Google App Script](#google-apps-script)
  - [Google sheet](#google-sheet)
- [Project structure](#project-structure)
- [Provider HomeView](#provider-homeview)
- [Google apps script api](#web-api)

## Configuration

### Flutter app

---
**Step 1:**

Download or clone this repo by using the link below:

```text
https://github.com/PepperoniOnzo/bloggy
```

**Step 2:**

Change `webApiUrl` in lib\data\constants\configurations.dart for your `Google Apps Script Web App` URL.

```dart
class AppConfig {
  static const String webApiUrl =
    "YOUR_WEB_APP_URL";
}
```

**Step 3:**

Go to project root and execute the following command in console to get the required dependencies:

```bash
flutter pub get 
```

**Step 4:**

Open emulator in which will build application. Run the following command in console to build the app:

```bash
flutter run lib\main.dart 
```

### Google Apps Script

---
**Step 1:**

> Go to <https://script.google.com/home> and create new web app.

**Step 2:**

> Paste code from `script.js` which in root project folder `google_app_script`. Change `SHEET_ID` for your google sheet ID.

**Step 3:**

> Deploy your app and enable permissions acess if needed.

### Google Sheet

---

**Step 1:**

> Create new Google Sheet, and copy google sheet ID from URL.
>> For example: `https://docs.google.com/spreadsheets/d/1YkGgsvc4_KMGKLCKq-oj5EuFTszxd9xH9BDCJXPjpGI/edit#gid=0` -> `1YkGgsvc4_KMGKLCKq-oj5EuFTszxd9xH9BDCJXPjpGI`

**Step 2:**

> Create sheet with name `settings`, or you can change name for setting sheet in script. Sheet must have row with key **juryName**, where you can define jury name for example `Jury Name`. Row with key **teamNames**, which will be names of sheets that will save team marks. **criteriaSequence** is sequences of criterias for example `Design`, `Functionality`. **criterias** is min and max mark. And nexr rows with the name of the criteria that you defined in **criteriaSequence** key and description for each mark. For example this is simple sheet that you must create:

| juryNames | jury1 | jury2 | jury3 | jury4 | jury5 |  e.t.c |
|-----------|:-----------:|-----------:|-----------:| -----------:| -----------:| -----------:|
| teamNames | team1 | team2 | team3 |  e.t.c |
| criteriaSequence | criteria 1 | criteria 2 |  e.t.c |
| criterias | 0 | 1 | 2 | 3 | 4 | 5 |
| criteria 1 | description 0 |  description 1 |  description 2 |  description 3 |  description 4 |  description 5 |
| criteria 2 | description 0 |  description 1 |  e.t.c |
| e.t.c. |

**Step 3:**

> Create sheets with the name that you defined in **teamNames**. For example this is simple sheet that you can create:

|  | criteria 1 | criteria 2 | criteria 3 | criteria 4 | criteria 5
|-----------|:-----------:|-----------:|-----------:| -----------:| -----------:|
| jury1 | 0| 1 | 0 | 0 | 0 |
| jury2 | 1 | 0 | 3 | 0 | 0 |
| jury3 | 1 | 0 | 0 | 2 | 0 |
| jury4 | 0 | 3 | 3 | 3 | 0 |
| jury5 | 0 | 2 | 3 | 3 | 3 |

## Project structure

Here is the folder structure I have been using in this project:

```text
lib/
|- data/
|- screens/
|- services/
|- views/
|- widgets/
|- main.dart
```

### Data

Data folder contains models and constans files.

```text
data/
|- constants/
    |- colors.dart
    |- configurations.dart
    |- http_constants.dart
|- models/
    |- post_marks_model.dart
    |- result.dart
|- routes/
    |- routes.dart
```

## Screens and widgets

These directories contain all widgets and screens of app.

```text
screens/
widgets/
```

## View and service

Directory views contains home_view wich extends by `ChangeNotifier` and with mixin `HttpService` from directory services.

```text
services/
views/
```

## Provider HomeView

Class `HomeView` contains all business logic for app. Which is responsible for the state of the home screen and team marks. Also, this class use mixin `HttpService` for making http requests to web application.

```text
Variables:
    - bool initialized - check if data is loaded.
    - List<String> jury, teams, criteriaSequence - team, jury, criteria sequence names.
    - Map<String, List<String>> criterias - maps criteria and criterias descriptions.
    - List<TeamMarks> teamMarks - all team marks.
    - List<int> currentMarks - current marks that user can set for team.

Methods
    - initialize - gather data from google sheet, and initializate view varaibles. 
    - tryRefresh - method for refreshing on error.
    - submit - submiting new marks for team in google sheet.
```

## Web Api

Web api is Google App Script project that serves as an intermediate layer between the Flutter App and Google Sheets, collect parameters, make request to sheet api, and saves data in the sheet.

Web Api configuration. Enum `Actions` is for names of request. Enum `Setings` is for json keys.

```js
const Actions = {
  getInitialData: "getInitialData",
  postMarks: "postMarks"
}

const Settings =
{
  juryNames: "juryNames",
  teamNames: "teamNames",
  criteriaSequence: "criteriaSequence",
  criterias: "criterias",
  marks: "marks"
}

const SHEET_ID = "YOUR_SHEET_ID";
const SHEET_SETTINGS = "settings";
```

Example of response calling method `getInitialData`.

```js
{
    "status": "SUCCESS",
    "data": {
        "juryNames": [
            "jury1"
        ],
        "teamNames": [
            "team1"
        ],
        "criteriaSequence": [
            "criteria1"
        ],
        "criterias": {
            "criteria 1": [
                "description0 criteria 1",
                "description1 criteria 1"
            ]
        },
        "marks": {
            "team1": {
                "jury1": [
                    0,
                    0
                ]
            }
        }
    }
}
```
