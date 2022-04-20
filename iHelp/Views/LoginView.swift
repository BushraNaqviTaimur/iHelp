//
//  LoginView.swift
//  iHelp
//
//  Created by Bushra on 1/6/22.
//


import SwiftUI
import Firebase
import FirebaseFirestore


class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userID = Auth.auth().currentUser

    
  
    
   @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
 

    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            //success
           
           DispatchQueue.main.async {
                self?.signedIn=true
            }
            
    }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            
    // Success
            DispatchQueue.main.async {
                self.signedIn=true
                self.userID = Auth.auth().currentUser
        }
                                                                
    }
    }
    
    func registerUserDetails(phone: Int, gender: String) {
        
        Auth.auth().addStateDidChangeListener { (auth, userID) in
          if (userID != nil) {
              self.db.collection("Users").document(userID!.uid).setData([
              "Phone": phone,
              "Gender": gender
              ])
          }
        }
    
         /*{ (err) in
            if err != nil{
        self.alertMsg = err!.localizedDescription
        self.alert.toggle()
        return
        } */
        // Success.
        
    }
    
    

    
    func signOut() {
        
    try? auth.signOut()
        
    self.signedIn = false
        
    }
    
    
    
    
    
    
}

//let storedUsername = "Myusername"
//let storedPassword = "Mypassword"

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var email = ""
    @State var password = ""
    
  //  @State var authenticationDidFail: Bool = false
  // @State var authenticationDidSucceed: Bool = false
       
       @State var editingMode: Bool = false
    @State private var scale: CGFloat = 1
    
    var body: some View {
        /*NavigationView{
        if viewModel.signedIn{
            VStack{
        Text ("You are signed in")
            }
        }
        else {
           
        RegistrationForm()
        }
        }
        .onAppear {

        viewModel.signedIn=viewModel.isSignedIn
        } */
        
        ZStack{
        VStack {
            
            Logo()
            
            TextField("Email Address", text: $email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            SecureField("Password", text: $password)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background (Color(.secondarySystemBackground))
            
            Button(action: {
            guard !email.isEmpty, !password.isEmpty else {
            return
            }
                viewModel.signIn(email: email, password: password)
            
            },label:
            {
            Text ("LOGIN")
                    .foregroundColor(Color.white)
                    .frame (width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.green)
            })
            
            NavigationLink("Don't have an account?, Sign up", destination: RegistrationForm())
                .padding()
                    
                    
      /*      UsernameTextField(email: $email, editingMode: $editingMode)
                            PasswordSecureField(password: $password)
                            if authenticationDidFail {
                                Text("Information not correct. Try again.")
                                    .offset(y: -10)
                                    .foregroundColor(.red)
                            }
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                        }
                        viewModel.signIn(email: email, password: password)
                        
                            
                           
                        //actioncode
                       if self.email == storedUsername && self.password == storedPassword {
                                               self.authenticationDidSucceed = true
                                               self.authenticationDidFail = false
                                           } else {
                                               self.authenticationDidFail = true
                                           }
                        
                   } ) {
                        
                       LoginButtonContent()
                    } */
            HStack{
                /*Text("Don't have an account?").foregroundColor(Color.black)
                
                Button( action:{
                    //action
                    //RegistrationForm()
                }){
                    Text("Sign Up")
                } */
            }.padding(.top, 50)

                }//end of vstack
            
            
          /*  if authenticationDidSucceed {
                            Text("Login succeeded!")
                                .font(.headline)
                                .frame(width: 250, height: 80)
                                .background(Color.green)
                                .cornerRadius(20.0)
                                .foregroundColor(.white)
                                //change
                                .animation(.linear(duration: 1), value: scale)

                        } */
            
            
     //end of zstack
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .top, endPoint: .bottomTrailing))
        .offset(y: editingMode ? -150 : 0)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct Logo : View {
    var body: some View {
        return Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

/*
struct LoginButtonContent : View {
    var body: some View {
        return Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct UsernameTextField : View {
    
    @Binding var email: String
    
    @Binding var editingMode: Bool
    
    var body: some View {
        return TextField("Email", text: $email, onEditingChanged: {edit in
            if edit == true
            {self.editingMode = true}
            else
            {self.editingMode = false}
        })
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding()

    }
}

struct PasswordSecureField : View {
    
    @Binding var password: String
    
    var body: some View {
        return SecureField("Password", text: $password)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding()

    }
} */
