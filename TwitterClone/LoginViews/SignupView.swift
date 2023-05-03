//
//  SignupView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 21/04/23.
//

import SwiftUI

struct SignupView: View {
    @State var username: String = ""
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var message = ""
    @State var isRegistered = false
    var body: some View {
        NavigationStack{
            ZStack(alignment: .top){
                TwitterTopBarWithoutImage()
                VStack(spacing: 30){
                
                    
                        
                    Spacer()
                        Text("Sign Up to Twitter")
                            .font(.system(size: 30, weight: .heavy))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal,30)
                    VStack(spacing:20){
                        Text(message)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color(.systemRed))
                            .padding(.horizontal,35)
                        TextField("Enter username", text: $username)
                            .font(.headline)
                            .bold()
                            .foregroundColor(Color.primary)
                            .frame(width: UIScreen.main.bounds.width-90, height: 70)
                            .padding(.horizontal)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            }
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        TextField("Enter name", text: $name)
                            .font(.headline)
                            .bold()
                            .foregroundColor(Color.primary)
                            .frame(width: UIScreen.main.bounds.width-90, height: 70)
                            .padding(.horizontal)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            }
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        TextField("Enter email", text: $email)
                            .font(.headline)
                            .bold()
                            .foregroundColor(Color.primary)
                            .frame(width: UIScreen.main.bounds.width-90, height: 70)
                            .padding(.horizontal)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            }
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        
                        SecureField("Password", text: $password)
                            .font(.headline)
                            .bold()
                            .frame(width: UIScreen.main.bounds.width-90, height: 70)
                            .padding(.horizontal)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            }
                    }
                    Spacer()
                    Button {
                        let network = NetworkCalls()
                        Task {
                            if(email != "" && password != "")
                            {
                                if(await !network.registerRequest(formData: LoginParameters(_id: "01", email: email, name: name, password: password, username: username)))
                                {
                                    message = "Error Registering User"
                                }
                                else{
                                    isRegistered = true
                                }
                            }
                            else{
                                message = "Enter All Values"
                            }
                        }

                    } label: {
                        Text("Sign up")
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width-90, height: 60)
                            .background(Color(.systemBlue))
                            .cornerRadius(50)
                    }
                    Spacer()
             
                }
            }.navigationDestination(isPresented: $isRegistered) {
                LoginView()
            }
            .navigationTitle("")
            .gesture(DragGesture()
                            .onChanged { value in
                                if value.translation.height > 0 {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            }
                        )
            }
            
        
        
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
