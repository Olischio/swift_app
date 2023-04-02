//
//  homepage.swift
//  apiapp
//
//  Created by Oliver Schiøtt on 30/03/2023.
//

import Foundation
import SwiftUI

//Setter brukernavn og passord til å preutfylle input feltet
//showingAlert og alertMessage blir brukt for error melding
//
struct LoginPage: View {
    @State private var username = "kmeus4"
    @State private var password = "aUTdmmmbH"
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showUserPage = false
    @State private var loggedInUser = loginResponse()

    var body: some View {
        //NavigationView(en) er brukt til at Navigationlinken skal kunne sende deg til ProductView, den gjør også at navigationtitle kan vises
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
                //$showUserPage blir toggled til true når man trykker på knappen og så blir du sendt til UserDataView
                NavigationLink(destination: UserDataView(userData:loggedInUser), isActive: $showUserPage) {
                                    //Gjør at man ikke kan se at loginknappen er en link til ett annet view
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

    //Denne funksjonen logger deg inn og sender deg til UserDataView
    func login() {
        let url = URL(string: "https://dummyjson.com/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //Gjør at serveren jeg sender data til vet at det jeg sender er JSON data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //Gjør dataen om til JSON
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["username": username, "password": password])

        
        //Sjekker om statuscoden er 200 OK, hvis ikke har noe gått gærent og error popupen vil vises
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200 {
                // Login successful
                print(String(data: data, encoding: .utf8)!)
                
                //Hvis statuscoden er 200 OK vil det si at loginen fungerte, dataen blir så lagret i Structen loginResponse
                do {
                    let myStruct = try JSONDecoder().decode(loginResponse.self, from: data)
                    self.loggedInUser = myStruct
                    //Her settes showUserPage til true slik at navigationlinken sender deg videre til UserDataView
                    self.showUserPage = true
                } catch {
                    print(error.localizedDescription)
                }
                
            } else {
                print("FEILET")
                // Login failed
                DispatchQueue.main.async {
                    //Det er her showingAlert og alertMessage @State(ene) fra toppen blir brukt til å vise en popup hvis du skriver feil passord
                    //Grunnen til at dette bruker variabler er fordi til å begynne med skulle login siden vise popup for både feil og riktig utført login
                    //Dette ble senere byttet til at fungerende login tar deg til UserDataView isteden
                    
                    self.showingAlert = true
                    self.alertMessage = "login feil"
                }
            }
        }.resume()
    }
}

//Structen som inneholder informasjonen som blir brukt i UserDataView
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
