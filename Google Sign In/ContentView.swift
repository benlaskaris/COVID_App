//
//  ContentView.swift
//  Google Sign In
//
//  Created by S Lasher on 9/9/20.
//  Copyright © 2020 S Lasher. All rights reserved.
//

import SwiftUI
import MapKit

import Firebase
import GoogleSignIn
import FirebaseFirestore

import SwiftUI
import MapKit

import Firebase
import GoogleSignIn
import FirebaseFirestore

struct ContentView: View {
    @State var authenticationDidFail: Bool = false
    
    var body: some View {
            
            ZStack {
                
                Color(white: 50)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Image("covid-icon").resizable()
                        .frame(width: 300.0, height: 300.0).clipShape(Circle()).overlay(
                            Circle().stroke(Color.gray, lineWidth: 4))
                        .shadow(radius: 10).padding(.bottom, 50).offset(y:30)
                    
                    VStack(alignment: .leading) {
                        Text("COVID-19 Symptom Check").bold().font(.title)
                        Text("By Terriers, for Terriers").bold()
                    }
                }
                LoginScreen()
            }
        
    }
}

struct LoginScreen: View{
    var body: some View{
        NavigationView{
            if Auth.auth().currentUser?.uid == nil{ //TODO: Change to != After User is added to DB
                NavigationLink(destination: HomeView()){
                    Text("Login")
                    
                }.navigationBarTitle("")
                .navigationBarHidden(true)
            }
            else{
                NavigationLink(destination: GoogleScreen()){
                    Text("Login")
                }.navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
    }
}

struct GoogleScreen: View{
    var body:some View{
        VStack{
            WrappedViewController()
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
    
    var body: some View {
        
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                }
                Image("covid-icon").resizable()
                .frame(width: 300.0, height: 300.0).clipShape(Circle()).overlay(
                Circle().stroke(Color.gray, lineWidth: 4))
                .shadow(radius: 10).padding(.bottom, 50).offset(y:30)
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
                    Text("Report my symptoms").font(.title)
                }.sheet(isPresented: self.$SymptomModal) {
                    SymptomView(SymptomModal: self.$SymptomModal)
                }
                    
                
                Button(action: {
                    self.TestingModal = true
                }) {
                    Text("Find Testing Locations").font(.title)
                }.sheet(isPresented: self.$TestingModal) {
                    TestingView()
                }
            }
        Spacer()
        }
    }
}

struct SymptomView: View {
    @Binding var SymptomModal: Bool
    
    var body: some View {
        VStack {
            
            Text("Daily Symptom Survey").font(.largeTitle).bold().padding()
            
            CheckView(symptom: "Fever of 100ºF or feeling unusually hot")
            
            CheckView(symptom: "New or worsening cough")
            
            CheckView(symptom: "Difficulty breathing")
            
            CheckView(symptom: "Sore throat")
            
            CheckView(symptom: "Loss of smell taste, or appetite")
            
            CheckView(symptom: "Vomiting")
            
            CheckView(symptom: "Severe Fatigue")
            
            CheckView(symptom: "Severe Body Aches")
            
            Button(action: {
                self.SymptomModal.toggle()
            }) {
                Text("Submit").font(.title).padding(.horizontal, 60).padding(.vertical, 5).background(Color.blue).foregroundColor(.white).cornerRadius(40).padding(.vertical, 30)
            }
        }
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
    
    func toggle() {
        isChecked = !isChecked
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
        let width : CGFloat = 260.0
        
        let button = UIButton(frame: CGRect(x: (screenWidth/2.0) - (width/2.2),
                                            y: (screenHeight) - (height/0.20),
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
        GIDSignIn.sharedInstance()?.restorePreviousSignIn() //RESTORE SIGN IN
        GIDSignIn.sharedInstance()?.signIn()
        
        //Checks if user is already in database. If not add them
        let db = Firestore.firestore()
        let userRef = db.collection("users")
        var ref: DocumentReference? = nil
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document {


                if document.exists{
                    print("Document data: \(document.data())")

                } else {

                print("Document does not exist")

                    
                    userRef.document(Auth.auth().currentUser!.uid).setData([
                        "profileName": Auth.auth().currentUser?.displayName as Any,
                        "recentSurvey": false,
                        "badge": "Red"
                    ])


                }
            }
        }
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
