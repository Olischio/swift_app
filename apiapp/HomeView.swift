//
//  rename.swift
//  apiapp
//
//  Created by Oliver Schiøtt on 31/03/2023.
//


import Foundation
import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LoginPage()) {
                    
                    Text("Log in")
                }
            }
            .navigationTitle("Home")
        }
    }
}
