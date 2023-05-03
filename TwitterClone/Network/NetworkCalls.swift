//
//  NwtworkCalls.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 27/04/23.
//

import Foundation
import UIKit

struct TokenModel : Codable{
    var token : String
}


struct NetworkCalls {
    
    let auth = Authenticate()
    let defaults = UserDefaults.standard
    
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
            let (data, resp) = try await URLSession.shared.data(for: request)
            let httpResponse = resp as! HTTPURLResponse
            
            if(httpResponse.statusCode != 200)
            {
                print("Error Logging")
                return false
            }
            let token = try JSONDecoder().decode(TokenModel.self, from: data)
            defaults.setValue(token.token, forKey: "jwt")
            auth.isAuthenticated = true
            return true
            
        }catch{
            print(error)
        }
        return false

    }
    
    
    func resetRequest(formData: LoginParameters) async -> Bool
    {
        let url = URL(string: "http://localhost:3000/reset-password")!
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
                print("Error Resetting")
                return false
            }
            return true
            
        }catch{
            print(error)
        }
        return false

    }
    
    func isLoggedIn() async -> Bool
    {
        let url = URL(string: "http://localhost:3000/status")!
        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
        guard let token = (defaults.string(forKey: "jwt"))
        else{
            return false
        }
        request.addValue(token, forHTTPHeaderField: "Authorization")

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
    
    
    
    func tweetRequest(tweetdata: TweetRequest) async -> Bool
    {
        let url = URL(string: "http://localhost:3000/tweet")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let token = (defaults.string(forKey: "jwt"))
        else{
            return false
        }
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            let reqData = try JSONEncoder().encode(tweetdata)
            request.httpBody = reqData
        }catch{
            print(error)
        }
        do{
            let (_, resp) = try await URLSession.shared.data(for: request)
            let httpResponse = resp as! HTTPURLResponse
            if(httpResponse.statusCode != 200)
            {
                print("Error Tweeting")
                return false
            }
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
    
    func allTweetData() async -> [TweetModel]
    {
        let url = URL(string: "http://localhost:3000/all")!
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode([TweetModel].self, from: data)
            return decodedData
        }catch{
            print(error)
        }
        return []
    }
    
    
    func uploadImage(_ image: UIImage) async {
        guard let url = URL(string: "http://localhost:3000/uploadpp") else { return }
        
        let boundary = UUID().uuidString
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let token = (defaults.string(forKey: "jwt"))
        else{
            return
        }
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        let imageData = image.jpegData(compressionQuality: 0.5)!
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        do{
            let (_, resp) = try await URLSession.shared.data(for: request)
            let httpResponse = resp as! HTTPURLResponse
            if(httpResponse.statusCode != 200)
            {
                print("Error Logging")
            }

//            auth.isAuthenticated = true
            
        }catch{
            print(error)
        }
    }
    
    
    func userDetails() async -> TwitterDataModel{
        guard let url = URL(string: "http://localhost:3000/userdata") else {  return TwitterDataModel(profilepicture: "", name: "", username: "") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = (defaults.string(forKey: "jwt"))
        else{
            return TwitterDataModel(profilepicture: "", name: "", username: "")
        }
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            let (data, resp) = try await URLSession.shared.data(for: request)
            let httpResponse = resp as! HTTPURLResponse
            if(httpResponse.statusCode != 200)
            {
                print("Error Logging")
                 return TwitterDataModel(profilepicture: "", name: "", username: "")
            }
            let userData = try JSONDecoder().decode(TwitterDataModel.self, from: data)
            return userData
        }
        catch{
            print(error)
        }
         return TwitterDataModel(profilepicture: "", name: "", username: "")
    }
}
