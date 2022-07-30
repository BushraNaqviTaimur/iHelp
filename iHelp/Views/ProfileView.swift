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



struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmpassword: String = ""
    @State var phoneNum: Int = 0
    @State var genderOptionSelected = "Other"
    @State var genderOption = ["Male", "Female", "Other"]
    //@State var registerStatus: Bool = false
    @State var zero: Int = 0
    
    
    
    
    
    var body: some View {
        
        ZStack{
            NavigationView{
                Form {
                    
                    Section(header: Text("EMAIL")) {
                         TextField("Email", text: $email)
                         
                     }
                    
                    
                 Section(header: Text("Change Password")) {
                     SecureField("New Password", text: $password)
                     .disableAutocorrection(true)
                     .autocapitalization(.none)
                     .padding()
                     .background (Color(.secondarySystemBackground))
                     
                     SecureField("Confirm New Password", text: $confirmpassword)
                     .disableAutocorrection(true)
                     .autocapitalization(.none)
                     .padding()
                     .background (Color(.secondarySystemBackground))
                     
                     

                     }
                 Section(header: Text("Change Mobile Number")) {
                     TextField("Phone number", value: $phoneNum,formatter: NumberFormatter())
                     
                 }
                 Section(header: Text("Change Gender")) {
                     
                     Picker("Select Gender", selection: $genderOptionSelected, content: {
                         ForEach(genderOption, id: \.self, content: {gender in
                             Text(gender)
                         })
                     })
                            .pickerStyle(MenuPickerStyle())
                            
                            //Text(genderOption[genderOptionTag])
                 
                 }
                }// form end
                .navigationBarTitle(Text("iHelp"), displayMode: .large )
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
            
        }//end of zstack
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AppViewModel())
    }
}

/*func SaveInfo(){
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    let userEmail = Auth.auth().currentUser?.email
    let mobile = Auth.auth().currentUser?.phoneNumber
    let currentUser = Auth.auth().currentUser
    let gender = Auth.auth().currentUser?.genderOptionSelected
    
        
        Auth.auth().addStateDidChangeListener { (auth, userID) in
          if (userID != nil) {
              self.db.collection("Users").document(userID!.uid).setData([
              "Phone": phoneNumber,
              "Gender": gender
              ])
          }
        }
    }
*/

