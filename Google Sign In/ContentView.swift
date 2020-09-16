////
//  AppDelegate.swift
//  Google Sign In
//
//  Created by S Lasher && Norman A. Toro Vega on 9/9/20.
//  Copyright © 2020 S Lasher. All rights reserved.
//


import SwiftUI
import MapKit

import Firebase
import GoogleSignIn
import FirebaseFirestore


class SurveyAnswers: ObservableObject {
    @Published var fever: Bool = false
    @Published var cough: Bool = false
    @Published var breathing: Bool = false
    @Published var throat: Bool = false
    @Published var smell: Bool = false
    @Published var vomit: Bool = false
    @Published var fatigue: Bool = false
    @Published var aches: Bool = false

}



struct ContentView: View {
  @State private var authenticationDidPass: Bool = false
    
//    @ObservedObject var survey = SurveyAnswers()
    
    var body: some View {
        NavigationView{
            if Auth.auth().currentUser?.uid != nil{
                NavigationLink(destination: HomeView()){
                        VStack(alignment: .center) {
                        //                        Spacer()
                                                
                                                Image("terrier-icon")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 180, alignment: .center)
                                                    .accessibility(hidden: true)
                                                
                                                TitleView()
                                                
                                                VStack(alignment: .leading) {
                                                    InformationDetailView(title: "Daily Symptom Survey", subTitle: "Fill out your daily health survey quickly and easily through one app.", imageName: "heart")

                                                    InformationDetailView(title: "Testing Locations", subTitle: "Find the COVID-19 testing location nearest to you to #FlattenTheCurve.", imageName: "mappin.circle")

                                                    InformationDetailView(title: "COVID-19 Statistics", subTitle: "See a detailed dashboard of all recent COVID-19-related statistics on campus.", imageName: "staroflife")
                                                }
                                                
                                                Spacer(minLength: 30)
                                                
                                                HStack {
                                                    Spacer()
                                                    Text("Get Started").customButton()
                                                    Spacer()
                                                }
                                           }.padding(.horizontal)

                                            }.navigationBarTitle("").buttonStyle(PlainButtonStyle())
                        //                .navigationBarHidden(true)
            }
            else
            {
                NavigationLink(destination: GoogleScreen()){
                    VStack(alignment: .center) {
//                        Spacer()
                        
                        Image("terrier-icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180, alignment: .center)
                            .accessibility(hidden: true)
                        
                        TitleView()
                        
                        VStack(alignment: .leading) {
                            InformationDetailView(title: "Daily Symptom Survey", subTitle: "Fill out your daily health survey quickly and easily through one app.", imageName: "heart")

                            InformationDetailView(title: "Testing Locations", subTitle: "Find the COVID-19 testing location nearest to you to #FlattenTheCurve.", imageName: "mappin.circle")

                            InformationDetailView(title: "COVID-19 Statistics", subTitle: "See a detailed dashboard of all recent COVID-19-related statistics on campus ", imageName: "staroflife")
                        }
                        
                        Spacer(minLength: 30)
                        
                        HStack {
                            Spacer()
                            Text("Login").customButton()
                            Spacer()
                        }
                   }.padding(.horizontal)

                    }.navigationBarTitle("").buttonStyle(PlainButtonStyle())
//                .navigationBarHidden(true)
            }
        }
    }
}

struct InformationDetailView: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding()
                .accessibility(hidden: true)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)

                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.top)
    }
}

struct TitleView: View {
    var body: some View {
        VStack {

            Text("Welcome to").fontWeight(.black)
                .font(.system(size: 36)).foregroundColor(.black)

            Text("TerrierCheck")
                .fontWeight(.black)
                .font(.system(size: 36))
                .foregroundColor(.red)
        }
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.mainColor))
            .padding(.bottom)
    }
}

extension View {
    func customButton() -> ModifiedContent<Self, ButtonModifier> {
        return modifier(ButtonModifier())
    }
}

extension Color {
    static var mainColor = Color(UIColor.systemRed)
}

struct GoogleScreen: View{
    var body:some View{
        NavigationView{
        VStack{
            
            Text("Sign In").fontWeight(.black)
                .font(.system(size: 36)).foregroundColor(.black)

            
            HStack(alignment: .center) {
                Spacer()
                Text("Use Your Google Account")
                .fontWeight(.black)
                .font(.system(size: 36))
                .foregroundColor(.red)
                Spacer()
            }
            
            Text("Please sign in here. After signing in, press the button at the bottom to enter Home.").font(.headline).padding()
            WrappedViewController()
            
            NavigationLink(destination: HomeView()){
                                    HStack {
                                        Spacer()
                                        Text("I'm Signed In").customButton()
                                        Spacer()
                                    }.padding(.horizontal)
                }.navigationBarTitle("").buttonStyle(PlainButtonStyle()).navigationBarHidden(true)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WrappedViewController: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> LoginViewController {
        let vc = LoginViewController()
        print("\nmakeUIViewController \(vc)")
        return vc
    }
    
    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        print("updateUIViewController \(uiViewController)")
    }
    
    static func dismantleUIViewController(_ uiViewController: LoginViewController, coordinator: Self.Coordinator) {
        print("distmantleUIViewController \(uiViewController)")
    }
}

struct HomeView: View {
    @State var SymptomModal: Bool = false
    @State var TestingModal: Bool = false
    @State var AdminModal: Bool = false
    @State var SurveyDone: Bool = false
    

    @State var status: String = "Overdue"
    @State var statusColor: Color = Color.yellow
    
//    @ObservedObject var survey: SurveyAnswers
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("").onAppear(){self.DB_Push()}
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                }
//                Image(systemName: "checkmark.square")
//                .font(.largeTitle)
//                .foregroundColor(.black)
//                    .overlay(RoundedRectangle(cornerRadius: 25, style: .continuous)
//                        .fill(Color.red)).frame(width: 200, height: 200)
                
                RoundedRectangle(cornerRadius: 25, style: .continuous).fill(statusColor)
                    .shadow(radius: 10).frame(width: 200, height: 200)
                
                Text("Status:").font(.largeTitle).bold().padding(.top)
                Text(status).font(.title).bold()
            }
            
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                Text("COVID-19 Symptom Check").bold().font(.title)
                Text("By Terriers, for Terriers").bold()
                }
            
                .padding()
                
                Button(action: {
                    self.SymptomModal = true
                }) {
                    Text("Report my symptoms").customButton().padding(.horizontal)
                }.sheet(isPresented: self.$SymptomModal) {
SymptomView(SymptomModal: self.$SymptomModal, statusColor: self.$statusColor, surveyDone: self.$SurveyDone)
                }
                    
                
                Button(action: {
                    self.TestingModal = true
                }) {
                    Text("Find Testing Locations").customButton().padding(.horizontal)
                }.sheet(isPresented: self.$TestingModal) {
                    TestingView()
                }
                
                Button(action: {
                    self.AdminModal = true
                }) {
                    Text("See Historical Data").customButton().padding(.horizontal)
                }.sheet(isPresented: self.$AdminModal) {
                    AdminView(AdminModal: self.$AdminModal)
                }
                if (SurveyDone==true){
                    Text("").onAppear(){self.DB_Push()}
                }
                
            }
        Spacer()
        }
    }
    
    func DB_Push(){
        //Checks if user is already in database. If not add them
        let db = Firestore.firestore()
        let userRef = db.collection("users")
        //        var ref: DocumentReference? = nil
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document {
                
                if document.exists {
                    //                    GIDSignIn.sharedInstance()?.restorePreviousSignIn() //RESTORE SIGN IN
                    print("Document data: \(document.data())")
                    let date = document.get("dateOfSurvey") as! String
                    if (date == Date().string(format: "dd-MM-yyyy")){
                        let badgeColor = document.get("badge") as! String
                        if badgeColor == "Red"{
                            self.statusColor = Color.red
                            self.status = "Quarantine"
                        }
                        else if (badgeColor == "Green"){
                            self.statusColor = Color.green
                            self.status = "Cleared"
                        }
                        else{
                            self.statusColor = Color.yellow
                            self.status = "Overdue"
                        }
                    }
                    
                } else {
                    //                    GIDSignIn.sharedInstance()?.signIn()
                    print("Document does not exist")
                    
                    userRef.document(Auth.auth().currentUser!.uid).setData([
                        "profileName": Auth.auth().currentUser?.displayName as Any,
                        "recentSurvey": false,
                        "badge": "Yellow",
                        "fever": false,
                        "cough": false,
                        "breathing": false,
                        "throat": false,
                        "smell": false,
                        "vomit": false,
                        "fatigue": false,
                        "aches": false,
                        "admin": false
                        
                    ])
                    self.statusColor = Color.yellow
                }
            }
        }
    }
    
}



struct SymptomView: View {
    @Binding var SymptomModal: Bool
    @Binding var statusColor: Color
    @Binding var surveyDone: Bool
    
    @State var buttonPush: Bool = false;
    
    @ObservedObject var survey = SurveyAnswers();
    
    var body: some View {
        VStack {
            
            Text("Daily Symptom Survey").font(.largeTitle).bold().padding()
            
            CheckView(symptom: "Fever of 100ºF or feeling unusually hot", symptomNumber: 1, survey: self.survey)
            
            CheckView(symptom: "New or worsening cough", symptomNumber: 2, survey: self.survey)
            
            CheckView(symptom: "Difficulty breathing", symptomNumber: 3, survey: self.survey)
            
            CheckView(symptom: "Sore throat", symptomNumber: 4, survey: self.survey)
            
            CheckView(symptom: "Loss of smell, taste, or appetite", symptomNumber: 5, survey: self.survey)
            
            CheckView(symptom: "Vomiting", symptomNumber: 6, survey: self.survey)
            
            CheckView(symptom: "Severe Fatigue", symptomNumber: 7, survey: self.survey)
            
            CheckView(symptom: "Severe Body Aches", symptomNumber: 8, survey: self.survey)
            


Button(action: {
                self.SymptomModal.toggle()
                let db = Firestore.firestore()
                let userRef = db.collection("users")
                
                
                var badge = "Green"
                if (self.survey.fever) { badge = "Red" }
                if (self.survey.cough) { badge = "Red" }
                if (self.survey.breathing) { badge = "Red" }
                if (self.survey.throat) { badge = "Red" }
                if (self.survey.smell) { badge = "Red" }
                if (self.survey.vomit) { badge = "Red" }
                if (self.survey.fatigue) { badge = "Red" }
                if (self.survey.aches) { badge = "Red" }
                
                let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
                
                docRef.getDocument { (document, error) in
                    if let document = document {
                        
                        if document.exists {
                            //                    GIDSignIn.sharedInstance()?.restorePreviousSignIn() //RESTORE SIGN IN
                            print("Document data: \(document.data())")
                            let date = document.get("dateOfSurvey") as! String
                            if (date == Date().string(format: "dd-MM-yyyy")){
                                print("less than a day has passed")
                            }
                            else{
                                //                    GIDSignIn.sharedInstance()?.signIn()
                                print("One Day has Passed")
                                
                                userRef.document(Auth.auth().currentUser!.uid).updateData([
                                    "profileName": Auth.auth().currentUser?.displayName as Any,
                                    "recentSurvey": true,
                                    "badge": badge,
                                    "fever": self.survey.fever,
                                    "cough": self.survey.cough,
                                    "breathing": self.survey.breathing,
                                    "throat": self.survey.throat,
                                    "smell": self.survey.smell,
                                    "vomit": self.survey.vomit,
                                    "fatigue": self.survey.fatigue,
                                    "aches": self.survey.aches,
                                    //"admin": false, // this should change - dummy value for now BL 09/14/2020
                                    "dateOfSurvey":Date().string(format: "dd-MM-yyyy")
                                ])
                                
                                self.surveyDone = true
                            }
                            
                        } else {
                            print("document does not exist")
                            
                        }
                    }
                }
                
            }) {
                Text("Submit").customButton().padding(.vertical, 30).padding(.horizontal)
            }

        }
        
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


struct TestingView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Find COVID-19 Testing Sites").font(.largeTitle).bold().padding(.top, 50).padding(.horizontal)
            MapView().frame(height: 200)
                
                NavigationView {
                    ScrollView {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                NavigationLink(destination: DetailView()) {
                                    Text("More Info")
                                }
                                Text("Agganis Arena")
                                    .font(.title)
                                HStack(alignment: .top) {
                                    Text("Charles River Campus")
                                        .font(.subheadline)
                                    Spacer()
                                    Text("925 Comm. Ave")
                                        .font(.subheadline)
                                }
                            }.padding()
                            
                            VStack(alignment: .leading) {
                                NavigationLink(destination: DetailView()) {
                                    Text("More Info")
                                }
                                    
                                    Text("808 Gallery")
                                        .font(.title)
                                    HStack(alignment: .top) {
                                        Text("Charles River Campus")
                                            .font(.subheadline)
                                        Spacer()
                                        Text("808 Comm. Ave")
                                            .font(.subheadline)
                                    }
                            }.padding()
                            
                            VStack(alignment: .leading) {
                                NavigationLink(destination: DetailView()) {
                                    Text("More Info")
                                }
                                    
                                    Text("Kilachand Center for Life Sciences")
                                        .font(.title)
                                    HStack(alignment: .top) {
                                        Text("Charles River Campus")
                                            .font(.subheadline)
                                        Spacer()
                                        Text("610 Comm. Ave")
                                            .font(.subheadline)
                                    }
                            }.padding()
                            
                            VStack(alignment: .leading) {
                                NavigationLink(destination: DetailView()) {
                                    Text("More Info")
                                }
                                    
                                    Text("BUMC")
                                        .font(.title)
                                    HStack(alignment: .top) {
                                        Text("Medical Campus")
                                            .font(.subheadline)
                                        Spacer()
                                        Text("72 E. Concord St")
                                            .font(.subheadline)
                                    }
                            }.padding()
                        }.navigationBarTitle("")
                        .navigationBarHidden(true)
                    }
            }
        }
    }
}

struct AdminView: View {
    @State var totalGreen = 0
    @State var totalRed = 0
    @State var totalYellow = 0
    @State var totalLate = 0
    @State var totalOnTime = 0
    @State var AdminView: Bool = false
    
    @Binding var AdminModal: Bool
    
    
    @State var Admin: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                        Text("").onAppear() {
                            self.readDB()
                        }
                        if self.Admin == true{
                                
                            HStack {
                                Spacer()
                                Text("Recent Statistics").font(.largeTitle).bold().padding(.top).onAppear() { self.readStatistics()
                                }
                                Spacer()
                            }
                            Spacer()
                            
                            if self.AdminView == true {
                                PieChart(totalGreen: self.$totalGreen, totalRed: self.$totalRed, totalYellow: self.$totalYellow)
                                
                                Text("Numerical Data").font(.largeTitle).bold().padding(.vertical)
                                
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("\(self.totalGreen)").font(.largeTitle).bold()
                                        Text("Total Cleared").font(.headline).bold()
                                    }
                                    Spacer()
                                }.padding(.bottom, 18)
                                
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("\(self.totalYellow)").font(.largeTitle).bold()
                                        Text("Total Warnings").font(.headline).bold()
                                    }
                                    Spacer()
                                }.padding(.bottom, 18)
                                
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("\(self.totalRed)").font(.largeTitle).bold()
                                        Text("Total Quarantined").font(.headline).bold()
                                    }
                                    Spacer()
                                }.padding(.bottom, 50)
                                
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("\(self.totalOnTime)").font(.largeTitle).bold()
                                        Text("Surveys Submitted On Time").font(.headline).bold()
                                    }
                                    Spacer()
                                }.padding(.bottom, 18)
                                
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("\(self.totalLate)").font(.largeTitle).bold()
                                        Text("Surveys Submitted Late").font(.headline).bold()
                                    }
                                    Spacer()
                                }.padding(.bottom, 18)
                                
                                
                            }
                        }
                    else{
                            Spacer()
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("You don't have permission to see historical data. Please contact your school IT Department for support.").fontWeight(.black)
                                    .font(.system(size: 25)).foregroundColor(.black).multilineTextAlignment(.center)
                                    Spacer()
                                }
                            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .edgesIgnoringSafeArea(.all).padding(.vertical, 250)
                            
                            Button(action: {
                                self.AdminModal.toggle()
                            }) {
                                Text("Return to Home").customButton().padding(.vertical, 90)
                            }

                    }
                }.padding(.horizontal)
        }
        
}
    func readDB(){
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        docRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                self.Admin = document.get("admin") as! Bool
            } else {
                print("Document does not exist in cache")
            }
        }
    }
    func readStatistics(){
        
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.AdminView = true
                for document in snapshot!.documents {
                    let badge = document.get("badge") as! String
                    let recentSurvey = document.get("recentSurvey") as! Bool
                    if badge == "Green"{
                        self.totalGreen = self.totalGreen + 1
                    }
                    else if badge == "Red"{
                        self.totalRed = self.totalRed + 1
                    }
                    else if badge == "Yellow"{
                        self.totalYellow = self.totalYellow + 1
                    }
                    if recentSurvey == false {
                        self.totalLate = self.totalLate + 1
                    }
                    else if recentSurvey == true {
                        self.totalOnTime = self.totalOnTime + 1
                    }
                }
            }
        }
    }
}

struct PieChart: View {
    @Binding var totalGreen: Int
    @Binding var totalRed: Int
    @Binding var totalYellow: Int
    @State var totalSurveys: Int = 0
    //@Binding var totalLate:Int
    //@Binding var totalOnTime:Int
    
    @State var data = [
        Pie(id: 0, percent: 40, name: "Cleared", color: Color.green),
        Pie(id: 1, percent: 40, name: "Warning", color: Color.yellow),
        Pie(id: 2, percent: 20, name: "Quarantine", color: Color.red)
    ]
    
    var body: some View {
        VStack {
            
//            ZStack {
//                Text("Recent Statistics").font(.largeTitle).fontWeight(.bold)
//            }.padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top).padding()
            
            GeometryReader {g in
                
                ZStack {
                    Text("").onAppear(){self.dataFiller()}
                    ForEach(0..<self.data.count) {i in
                        DrawShape(data: self.$data, center: CGPoint(x: g.frame(in: .global).width / 2, y: g.frame(in: .global).width / 2), index: i)
                    }
                }
            }.frame(height: 360)
                .padding(.top, 20)
                .clipShape(Circle())
                .shadow(radius: 8)
            
            VStack {
                ForEach(self.data) {i in
                    
                    HStack {
                        
                        Text(i.name).font(.headline).bold().frame(width: 100)
                        
                        GeometryReader{g in
                            
                            HStack {
                                
                                Spacer(minLength: 0)
                                
                                Rectangle().fill(i.color).frame(width: self.getWidth(width: g.frame(in: .global).width, value: i.percent),height: 10)
                                
                                Text(String(format: "\(i.percent)", "%.0f") + "%").fontWeight(.bold).padding(.leading, 10)
                            }
                        }
                    }.padding(.top, 18)
                }
            }.padding()
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    func getWidth(width: CGFloat, value: CGFloat)-> CGFloat {
        
        let temp = value / 100
        return temp * width
    }
    func dataFiller(){
        self.totalSurveys = totalYellow + totalRed + totalGreen
        self.data = [
            Pie(id: 0, percent: CGFloat(Float(totalGreen) / Float(totalSurveys) * 100), name: "Cleared", color: Color.green),
            Pie(id: 1, percent: CGFloat(Float(totalYellow) / Float(totalSurveys) * 100), name: "Overdue", color: Color.yellow),
            Pie(id: 2, percent: CGFloat(Float(totalRed) / Float(totalSurveys) * 100), name: "Quarantine", color: Color.red)
           ]
    }
}


struct DrawShape: View {
    @Binding var data: Array<Pie>
    var center: CGPoint
    var index: Int
    var body: some View {
        
        Path { path in
            
            path.move(to: self.center)
            path.addArc(center: self.center, radius: 180, startAngle: .init(degrees: self.from()), endAngle: .init(degrees: self.to()), clockwise: false)
        }.fill(data[index].color)
        
    }
    
    func from()-> Double{
        if index == 0 {
            return 0
        } else {
            var temp: Double = 0
            
            for i in 0...index-1 {
                temp += Double(data[i].percent / 100) * 360
            }
            
            return temp
        }
        
    }
    
    func to()-> Double {
          var temp: Double = 0
            
            for i in 0...index {
                temp += Double(data[i].percent / 100) * 360
            }
            
            return temp
        }
    }

struct Pie: Identifiable {
    var id: Int
    var percent: CGFloat
    var name: String
    var color: Color
}

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 42.3505, longitude: -71.1054)
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        
//        Agganis Arena
        let AgganisArena = CLLocationCoordinate2D(latitude: 42.3522, longitude: -71.1177)
        let AGGannotation = MKPointAnnotation()
        AGGannotation.coordinate = AgganisArena
        AGGannotation.title = "Agganis Arena"
        AGGannotation.subtitle = "Charles River Campus"
        uiView.addAnnotation(AGGannotation)
        
//        808 Gallery
        let EightOhEight = CLLocationCoordinate2D(latitude: 42.35015, longitude: -71.11173)
        let EGHTannotation = MKPointAnnotation()
        EGHTannotation.coordinate = EightOhEight
        EGHTannotation.title = "808 Gallery"
        EGHTannotation.subtitle = "Charles River Campus"
        uiView.addAnnotation(EGHTannotation)
        
//        Kilachand
        let Kilachand = CLLocationCoordinate2D(latitude: 42.349096, longitude: -71.101471)
        let KLCHND = MKPointAnnotation()
        KLCHND.coordinate = Kilachand
        KLCHND.title = "Kilachand Center for Life Sciences"
        KLCHND.subtitle = "Charles River Campus"
        uiView.addAnnotation(KLCHND)
        
//        BUMC
        let MedicalCampus = CLLocationCoordinate2D(latitude: 42.336676, longitude: -71.072470)
        let bmc = MKPointAnnotation()
        bmc.coordinate = MedicalCampus
        bmc.title = "BUMC"
        bmc.subtitle = "Medical Campus"
        uiView.addAnnotation(bmc)
    }
    
}

struct DetailView: View {
    var body: some View {
        VStack(alignment: .center) {
                Text("Testing Center Information").multilineTextAlignment(.center)
                    .font(.largeTitle).padding(.bottom)

                Text("For more information on testing center hours, procedures, and additional questions, please call Student Health Services at (617) 353-3575")
                    .font(.caption)
            Spacer()
        }.padding().navigationBarHidden(true)
        .navigationBarTitle(Text(""))
        .edgesIgnoringSafeArea([.top, .bottom])
        
    }
}



struct CheckView: View {
    @State var isChecked:Bool = false
    var symptom: String
    var symptomNumber: Int
    
    @ObservedObject var survey: SurveyAnswers;
    
    func toggle() {
        isChecked = !isChecked
        
        
        switch symptomNumber {
        case 1:
            self.survey.fever = isChecked
        case 2:
            self.survey.cough = isChecked
        case 3:
            self.survey.breathing = isChecked
        case 4:
            self.survey.throat = isChecked
        case 5:
            self.survey.smell = isChecked
        case 6:
            self.survey.vomit = isChecked
        case 7:
            self.survey.fatigue = isChecked
        case 8:
            self.survey.aches = isChecked

        default:
            print("Survey Answers")
        }
    }
    

    var body: some View {
        VStack (alignment: .leading) {
            Button(action: toggle) {
                HStack() {
                    Image(systemName: isChecked ? "checkmark.square": "square").resizable()
                    .frame(width: 35, height: 35)
                    Text(symptom).font(.headline).foregroundColor(.black)
                    Spacer()
                }.padding(.horizontal)
            }
        }
        
    }
    
}

class LoginViewController: UIViewController{
    override func viewDidLoad() {
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        
        let height : CGFloat = 40.0
        let width : CGFloat = 300.0
        
        let button = UIButton(frame: CGRect(x: 65,
                                            y: 0,
                                            width: width,
            height: height))
        
        let googleIcon = UIImage(named:"icons8-google-24")!
        button.leftImage(image: googleIcon, renderMode: .alwaysOriginal)
        
        button.backgroundColor = .white
        button.setTitle("Sign In with Google", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 20
        
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 00.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        
        button.addTarget(self, action: #selector(buttonAction), for:.touchUpInside)
        self.view.addSubview(button)
    }
    @objc func buttonAction(sender: UIButton!){
        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn() //RESTORE SIGN IN
        GIDSignIn.sharedInstance()?.signIn()
        

        //ref = db.collection("users").addDocument(data: [
          //  "userid": Auth.auth().currentUser?.uid as Any,
          //  "recentSurvey": false,
          //  "badge": "Green"
        // ])
        
    }
}

func didTapSignOut(_ sender:AnyObject){
    GIDSignIn.sharedInstance()?.signOut()
}
extension UIButton{
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for:.normal)
        self.imageEdgeInsets = UIEdgeInsets(top:0, left:image.size.width/2-30, bottom:0, right:0)
        self.contentHorizontalAlignment = .leading
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        self.imageView?.contentMode = .scaleAspectFit
    }
}
