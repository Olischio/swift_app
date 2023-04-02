//
//  homepage.swift
//  apiapp
//
//  Created by Oliver Schiøtt on 30/03/2023.
//

import Foundation
import SwiftUI

struct LoginPage: View {
    @State private var username = "kmeus4"
    @State private var password = "aUTdmmmbH"
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showUserPage = false
    @State private var loggedInUser = loginResponse()

    var body: some View {
        
        NavigationView {
            VStack {
                Text("Welcome to the login page!")
                    .font(.title)
                    .padding()
                TextField("Username", text: $username)
                    .padding()
                SecureField("Password", text: $password)
                    .padding()
                
                    Button(action: login) {
                        Text("Log in")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                }
                NavigationLink(destination: UserDataView(userData:loggedInUser), isActive: $showUserPage) {
                                    EmptyView()
                                }
                
                    
                    
                
                Spacer()
            }
        }
        
       
        .navigationTitle("Login")
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func login() {
        let url = URL(string: "https://dummyjson.com/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["username": username, "password": password])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200 {
                // Login successful
                print(String(data: data, encoding: .utf8)!)
                
                
                do {
                    let myStruct = try JSONDecoder().decode(loginResponse.self, from: data)
                    print("DETTE ER MYSTRUCT PRINTEN", myStruct)
                    self.loggedInUser = myStruct
                    self.showUserPage = true
                } catch {
                    print(error.localizedDescription)
                }
                
                
               // DispatchQueue.main.async {
                 //   self.showingAlert = true
                   // self.alertMessage = "login ok"
               // }
                
            } else {
                print("FEILET")
                // Login failed
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertMessage = "login feil"
                }
            }
        }.resume()
    }
}

struct loginResponse: Codable {
    var id: Int?
    var username: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var gender: String?
    var image: URL?
    var token: String?
}
