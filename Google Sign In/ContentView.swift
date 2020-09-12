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
            if Auth.auth().currentUser?.uid != nil{
                NavigationLink(destination: HomeView()){
                    Text("Login")
                }
            }
            else{
                NavigationLink(destination: GoogleScreen()){
                    Text("Login")
                }
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
    
    var body: some View{
        //...
        VStack{
        Button(action: {
            self.SymptomModal = true
        }) {
            Text("Report my symptoms").font(.headline)
        }.sheet(isPresented: self.$SymptomModal) {
            SymptomView(SymptomModal: self.$SymptomModal)
        }
            
        
        Button("Find Testing Locations") {
            self.TestingModal = true
        }.sheet(isPresented: $TestingModal, content: {
            MapView().frame(height: 300)
        })
        }
    }
}

struct SymptomView: View {
    @Binding var SymptomModal: Bool
    
    var body: some View {
        VStack {
            
            Text("Screen to report symptoms")
            CheckView().frame(height: 300)
            Button("Send Responses") {
                self.SymptomModal.toggle()
            }
        }
//            Form {
//                Group {
//                    Text("Please enter your name FORM")
//                }
//            }
            
        }
}

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 34.011286, longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct CheckView: View {
    @State var isChecked:Bool = false
    var title:String = "Severe Cough"
    func toggle() {
        isChecked = !isChecked
    }
    
    
    
    var body: some View {
        Button(action: toggle) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square": "square")
                Text(title)
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
