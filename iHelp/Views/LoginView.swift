//
//  LoginView.swift
//  iHelp
//
//  Created by Bushra on 1/6/22.
//

import SwiftUI

let storedUsername = "Myusername"
let storedPassword = "Mypassword"

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
       
       @State var editingMode: Bool = false
    @State private var scale: CGFloat = 1
    
    var body: some View {
        ZStack{
        VStack {
                    
                    Logo()
            UsernameTextField(email: $email, editingMode: $editingMode)
                            PasswordSecureField(password: $password)
                            if authenticationDidFail {
                                Text("Information not correct. Try again.")
                                    .offset(y: -10)
                                    .foregroundColor(.red)
                            }
                    Button(action: {
                        //actioncode
                        if self.email == storedUsername && self.password == storedPassword {
                                               self.authenticationDidSucceed = true
                                               self.authenticationDidFail = false
                                           } else {
                                               self.authenticationDidFail = true
                                           }
                        
                    }) {
                        
                       LoginButtonContent()
                    }
            HStack{
                Text("Don't have an account?").foregroundColor(Color.black)
                
                Button( action:{
                    //action
                }){
                    Text("Sign Up")
                }
            }.padding(.top, 50)

                }//end of vstack
            
            
            if authenticationDidSucceed {
                            Text("Login succeeded!")
                                .font(.headline)
                                .frame(width: 250, height: 80)
                                .background(Color.green)
                                .cornerRadius(20.0)
                                .foregroundColor(.white)
                                //change
                                .animation(.linear(duration: 1), value: scale)

                        }
            
            
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
}
