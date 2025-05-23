# Terrier COVID-19 Symptom Attestation App
Boston University EC 463 - Senior Design I

# Download
1. On your iPhone, go to https://tinyurl.com/getmyudid <br/>
2. Tap on “Tap to find UDID” <br/>
3. Tap on “Allow” <br/>
4. Go to the Settings App <br/>
5. Tap on “Profile Downloaded” <br/>
6. Tap on Install <br/>
7. Copy & paste the “UDID” number and send that to <redacted> <br/>

After you are added to our Developer Account, you can download the app here: <br/>
https://tinyurl.com/terriercheck <br/>
Note: You must open the link directly from an iOS Device and wait to be given access before being able to install it.

# Team Composition
<br/>Norman A. Toro Vega - Front-End Development 🎨 <br/>
- Created SwiftUI Views for every page
- Created a SwiftUI Checkbox Form for Daily Symptom Surveys
- Implemented MapViews for Testing Locations
- Implemented a PieChart Shape for Historical Data & Statistics
- Designed App Logo
- Developed App Walkthrough Video

<br/>Se'Lina Lasher - Backend Development 💻 <br/>
- Google Authentication via Google Sign In Button <br/>
- Automatic User Onboarding into Firebase Database <br/>
- Use of Navigation Links to Change Views<br/>
- Determining Admin Dashboard Permissions and Pulling Data from the Database<br/>
- Assisted Norman Toro Vega

<br/>Benjamin Laskaris - Backend Development 💻 <br/>
- Initial Firebase setup and testing <br/>
- Publish and retrieve survey results to/from database <br/>
- Use survey results to set user status badge <br/>
- Push timestamp of survey submission to Firebase to keep track of when next survey is due <br/>

# Software Stack
Developed with Swift, SwiftUI, and Google Firebase

# About the Project
This app was developed for providing BU Terriers the ability to submit their daily symptom survey, find testing locations, and see recent statistics on BU's COVID-19 Campus Plan <br/>
<br/>__**Front-End Design**__ <br/>
<br/>_Splash Screen_<br/>
The app was developed on SwiftUI mainly for its ease-of-use when creating User Interfaces. The Splash Screen showcases the BU Logo (which may be replaced by a propietary application logo in the future) and some information on the basics of what the app can accomplish. The app has functionalities for submitting your daily synmptom screening, finding testing locations, and seeing statistics on recent COVID surveys submitted by the population.

<br/>_Home View_<br/>
The Home View showcases the user's compliance checkmark, which will become green if they submitted their daily symptom report and have no symptoms, yellow if they are overdue on their survey, and red if they have reported any symptoms which require urgent medical attention. There are buttons for every corresponding feature of the application, which start a modal popup using Boolean toggle functions.

<br/>_Symptom Survey_<br/>
The symptom survey uses checkboxes, vertical stacks and horizontal stacks to provide the user a list of symptoms in which they can list out. This is tied to the database upon pressing the submit button shown below.

<br/>_Testing Locations_<br/>
For the testing locations, a MapView is used to showcase Boston University's Charles River Campus and the Medical Campus. A subview with testing locations and information on where to contact to obtain one is included. The points of interest are added individually, using a MapAnnotation.

<br/>_Historical Data_<br/>
The Historical Data view is only accessible by users that have a "true" set on their database item. If they don't have permission to view this, a view comes up telling them to contact their local IT department for further assistance. If they are an admin, they are able to see a PieChart View that contains a distribution of how many of the current day's surveys were completed with no symptoms, how many are overdue, and how many have to quarantine. The information is also displayed numerically below.

<br/>__**Backend Design**__ <br/>
<br/>_Google Authentication via Google Sign In Button_ <br/>
Initially, when launching the application for the first time, a user is prompted to sign in using Google. Using the documentation provided by Firebase and a Youtube tutorial we were able to implement a Google themed button that when used to sign in adds a new authenticated user to the database. The Google sign in knows when to add a new user by searching the current authenticated users in the database and if the email used to sign in does not exist then add them to the authenticated user in the datbase. <br/>
<br/>_Automatic User Onboarding into Firebase Database_<br/>
When launching the application, whether the user is new or not, the Home Screen will eventually be called. Once called, a function is used to determine if the current user is new to the database or not. If the user is new then the user and default values ("admin", "recent survey completed", "name", etc.) are pushed to the database to be accessed throughout the rest of the application. However, if the user is not new then they already exist in the database and their fields are used throughout to determine badge color, admin status and the current status of their survey.<br/>
<br/>_Use of Navigation Links to Change Views_<br/>
Navigation Links are used throughout the app to easily transition between multiple screens. For example, to determine when launching the app, the software needs to determine which screen to show the user, either the login screen (the user is either new or signed out) or the Home Screen (bipassing the login screen because the user is already signed in). To decide which screen to show a conditoinal is used ( is the user id empty or not) and upon evaluation of that conditional a Login link is presented to the user that when clicked takes them to the appropriate screen. <br/>
<br/> _Determining Admin Dashboard Permissions and Pulling Data from the Database_<br/>
The admin dashboard is a part of the native app. To determine who can view the dashboard a conditional statement is used. Each user has a field in the database ("admin") a bool that is either true (you're an admin) or false. If false then you cannot see the admin dashboard, however, if true then a pie chart holding the data for number of each badge color assigned to readers is displayed. As well, as the total number of late surveys and on time surveys. <br/>

# References
Splash Screen: <br/>
https://medium.com/better-programming/creating-an-apple-like-splash-screen-in-swiftui-fdeb36b47e81
<br/>
Google Authentication via Firebase:<br/>
https://www.youtube.com/watch?v=hGDaemst2UA <br/>
Firebase Docs: <br/>
https://firebase.google.com/docs/auth/ios/google-signin
