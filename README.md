# Terrier COVID-19 Symptom Attestation App
Boston University EC 463 - Senior Design I

# Team Composition
Norman A. Toro Vega - Front-End Development 🎨 <br/>
<br/>Se'Lina Lasher - Backend Development 💻: <br/>
-Google Authentication via Google Sign In Button <br/>
-Automatic User Onboarding into Firebase Data Base <br/>
-Use of Navigation Links to Change Views<br/>
-Determining Admin Dashboard Permissions and Pulling Data from the Database<br/>
<br/>Benjamin Laskaris - Backend Development 💻<br/>

# Software Stack
Developed with Swift, SwiftUI, and Google Firebase

# About the Project
This app was developed for providing BU Terriers the ability to submit their daily symptom survey, find testing locations, and see recent statistics on BU's COVID-19 Campus Plan <br/>
__**Backend Design**__ <br/>
_Google Authentication via Google Sign In Button_ <br/>
Initially, when launching the application for the first time, a user is prompted to sign in using Google. Using the documentation provided by Firebase and a Youtube tutorial we were able to implement a Google themed button that when used to sign in adds a new authenticated user to the database. The Google sign in knows when to add a new user by searching the current authenticated users in the database and if the email used to sign in does not exist then add them to the authenticated user in the datbase. <br/>


# References
Splash Screen: <br/>
https://medium.com/better-programming/creating-an-apple-like-splash-screen-in-swiftui-fdeb36b47e81
<br/>
Google Authentication via Firebase:<br/>
https://www.youtube.com/watch?v=hGDaemst2UA
Firebase Docs: <br/>
https://firebase.google.com/docs/auth/ios/google-signin
