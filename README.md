# Terrier COVID-19 Symptom Attestation App
Boston University EC 463 - Senior Design I

# Team Composition
Norman A. Toro Vega - Front-End Development 🎨 <br/>
<br/>Se'Lina Lasher - Backend Development 💻 <br/>
-Google Authentication via Google Sign In Button <br/>
-Automatic User Onboarding into Firebase Database <br/>
-Use of Navigation Links to Change Views<br/>
-Determining Admin Dashboard Permissions and Pulling Data from the Database<br/>
-Assisted Norman Toro Vega: 

<br/>Benjamin Laskaris - Backend Development 💻<br/>
-Initial database setup and testing <br/>
-Publish Survey results to Database and use them to set user badge <br/>

# Software Stack
Developed with Swift, SwiftUI, and Google Firebase

# About the Project
This app was developed for providing BU Terriers the ability to submit their daily symptom survey, find testing locations, and see recent statistics on BU's COVID-19 Campus Plan <br/>
<br/>__**Front-End Design**__ <br/>
<br/>_Splash Screen_<br/>
The app was developed on SwiftUI mainly for its ease-of-use when creating User Interfaces. The Splash Screen showcases the BU Logo (which may be replaced by a propietary application logo in the future) and some information on the basics of what the app can accomplish. The app has functionalities for submitting your daily synmptom screening, finding testing locations, and seeing statistics on recent COVID surveys submitted by the population.

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