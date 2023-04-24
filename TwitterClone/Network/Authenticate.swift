//
//  Authenticate.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 24/04/23.
//

import Foundation


struct LoginParameters : Codable{
    var _id : String
    var email : String
    var password : String
    var username : String?
}

class Authenticate : ObservableObject{
    @Published var isAuthenticated = false
    
}


struct NetworkCalls {
    let auth = Authenticate()
    func loginRequest(formData: LoginParameters) async -> Bool
    {
        let url = URL(string: "http://localhost:3000/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            let reqData = try JSONEncoder().encode(formData)
            request.httpBody = reqData
        }catch{
            print(error)
        }
        
        do{
            let (_, resp) = try await URLSession.shared.data(for: request)
            let httpResponse = resp as! HTTPURLResponse
            
            if(httpResponse.statusCode != 200)
            {
                print("Error Logging")
                return false
            }
            auth.isAuthenticated = true
            return true
            
        }catch{
            print(error)
        }
        return false

    }
    
    func registerRequest(formData: LoginParameters) async -> Bool
    {
        let url = URL(string: "http://localhost:3000/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            let reqData = try JSONEncoder().encode(formData)
            request.httpBody = reqData
        }catch{
            print(error)
        }
        
        do{
            let (_, resp) = try await URLSession.shared.data(for: request)
            let httpResponse = resp as! HTTPURLResponse
            if(httpResponse.statusCode != 200)
            {
                print("Error Logging")
                return false
            }
            return true
//            auth.isAuthenticated = true
            
        }catch{
            print(error)
        }
        return false
    }
}

