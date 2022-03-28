//
//  RegistrationForm.swift
//  iHelp
//
//  Created by Bushra on 1/12/22.
//

import SwiftUI
import FirebaseAuth



    let auth = Auth.auth()
    
  
    
   


    

    


struct RegistrationForm: View {
    
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmpassword: String = ""
    @State var phoneNum: Int = 0
    @State var genderOptionTag: Int = 0
    var genderOption = ["Male", "Female", "Other"]
    @State var registerStatus: Bool = false
    @State var zero: Int = 0
    
    
    

    
    var body: some View {
        
      
        ZStack {
            NavigationView {
                           Form {
                                  Section(header: Text("EMAIL")) {
                                       TextField("Email", text: $email)
                                       
                                   }
                               
                               
                               Section(header: Text("Password")) {
                                   SecureField("Password", text: $password)
                                   .disableAutocorrection(true)
                                   .autocapitalization(.none)
                                   .padding()
                                   .background (Color(.secondarySystemBackground))
                                   
                                   SecureField("Re-enter Password", text: $confirmpassword)
                                   .disableAutocorrection(true)
                                   .autocapitalization(.none)
                                   .padding()
                                   .background (Color(.secondarySystemBackground))
                                   
                                   

                                   }
                               Section(header: Text("Phone")) {
                                   TextField("Phone number", value: $phoneNum,formatter: NumberFormatter())
                                   
                               }
                               Section(header: Text("Gender")) {
                                   
                                   Picker("Options", selection: $genderOptionTag)
                                   {
                                       Text("Options").tag(0)
                                Text("Female").tag(1)
                                Text("Other").tag(2)
                                       Text("Male").tag(3)
                                          }
                                   
                                          .pickerStyle(MenuPickerStyle())
                                          
                                          //Text(genderOption[genderOptionTag])
                               
                               }
                               Button(action: {
                                   
                                   
                                       self.registerStatus = true
                                   guard !email.isEmpty, !password.isEmpty else {
                                   return
                                   }
                                   viewModel.signUp(email: email, password: password)
                               }, label: {
                                   HStack {
                                       Spacer()
                                       Text(registerStatus ? "Registered" : "Register")
                                       Spacer()
                                   }
                               }).disabled(registerStatus)
                               
                                   }.navigationBarTitle(Text("iHelp"), displayMode: .large )
                    .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .top, endPoint: .bottomTrailing))
                        .onAppear { // ADD THESE
                          UITableView.appearance().backgroundColor = .clear
                        }
                        .onDisappear {
                          UITableView.appearance().backgroundColor = .systemGroupedBackground
                        }
                        
                        
           }
        }
            
        /*func validationOfTextFields() -> Bool{
            var a = false
            if( password.isEmpty || confirmpassword.isEmpty || email.isEmpty
                || self.phoneNum.
               //|| self.$genderOptionTag == "Options"
                
              
            )
        {
                let alertController = UIAlertController(title: "Error", message: "Please Enter All text Fields", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)

          //if signUpPassword.text != signUpConfirmPassword.text {
                  //  let alertController = UIAlertController(title: "Error", message: "Passwords don't Match", preferredStyle: .alert)
                   // let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                  //  alertController.addAction(defaultAction)
                  //  self.present(alertController, animated: true, completion: nil)
               // }
                
                else
                {
                    a = true
                }
            }

             return a
        }*/

                   
    }
}

struct RegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationForm()
    }
}

