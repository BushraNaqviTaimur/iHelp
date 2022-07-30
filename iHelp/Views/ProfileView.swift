//
//  ProfileView.swift
//  iHelp
//
//  Created by Bushra on 1/15/22.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore


    
    //let auth = Auth.auth()
   

   // @Published var errorMessage = "" //published variable to handle error message

    
    
    
    


struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var newEmail: String = ""
    @State var newPassword: String = ""
    @State var newConfirmpassword: String = ""
    @State var NewphoneNum: Int = 0
   
    //@State var registerStatus: Bool = false
    @State var zero: Int = 0
   // @Published var errorMessage = "" //published variable to handle error message
    
    
    
    var body: some View {
        
        ZStack{
            NavigationView{
                Form {
                    
                    Section(header: Text("EMAIL")) {
                         TextField("Email", text: $newEmail)
                         
                     }
                    
                    
                 Section(header: Text("Change Password")) {
                     SecureField("New Password", text: $newPassword)
                     .disableAutocorrection(true)
                     .autocapitalization(.none)
                     .padding()
                     .background (Color(.secondarySystemBackground))
                     
                     SecureField("Confirm New Password", text: $newConfirmpassword)
                     .disableAutocorrection(true)
                     .autocapitalization(.none)
                     .padding()
                     .background (Color(.secondarySystemBackground))
                     
                     

                     }
                 Section(header: Text("Change Mobile Number")) {
                     TextField("Phone number", value: $NewphoneNum,formatter: NumberFormatter())
                     
                 }
                 
                    
                    Button(action: {
                        
                        
                            //self.registerStatus = true
                        guard !newEmail.isEmpty, !newPassword.isEmpty else {
                        return
                        }
                        
                        if newPassword==newConfirmpassword
                        {
                            viewModel.setpass(password: newPassword)
                        //viewModel.signUp(email: email, password: password)
                        viewModel.UpdateUserDetails(phone:NewphoneNum ,email: newEmail)
                        self.viewModel.errorMessage="" //clearing error message so that UI is clean on sign out
                        }
                        else
                        {
                            self.viewModel.errorMessage="Password and confirm password are not same."
                        }
                    }, label: {
                        HStack {
                            Spacer()
                            //Text(registerStatus ? "Registered" : "Register")
                            Text("Save Changes")
                            Spacer()
                        }
                    })//.disabled(registerStatus)
                        .disabled(self.newEmail.isEmpty)
                        .disabled(self.newPassword.isEmpty)
                        .disabled(self.newConfirmpassword.isEmpty)
                        .disabled(self.NewphoneNum==0)
                    
                    
                    
                    
                }// form end
                .navigationBarTitle(Text("MyAccount"), displayMode: .large )
                .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .top, endPoint: .bottomTrailing))
              .onAppear { // ADD THESE
               UITableView.appearance().backgroundColor = .clear
                 self.viewModel.errorMessage="" //clearing error message so that UI is clean on load
                         }
             .onDisappear {
               UITableView.appearance().backgroundColor = .systemGroupedBackground
                 self.viewModel.errorMessage="" //clearing error message so that UI is clean on Back
                          }
                
                
                
                
            }// end of nav
            
            .edgesIgnoringSafeArea(.top)
        }//end of zstack
        
    }
    
    
    
    
    
    
    /*func SaveInfo(){
        

        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid
        let email = Auth.auth().currentUser?.email
        let mobile = Auth.auth().currentUser?.phoneNumber
        let currentUser = Auth.auth().currentUser
        
        db.collection("Users").document("\(userID!)").updateData("Email" : newEmail, "Phone" : NewphoneNum)
        
        Auth.auth().currentUser?.updateEmail(to: newEmail){error in
            if let error = error {
                print(error)
            }
        }
       // if userEmail.text
           // guard !email.isEmpty, !password.isEmpty//
            
        }*/
    
    
    
    
    
    
    
    
    
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AppViewModel())
    }
}



