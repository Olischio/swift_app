//
//  File.swift
//  apiapp
//
//  Created by Oliver Schiøtt on 31/03/2023.
//



import Foundation
import SwiftUI

struct userDataView: View {
    var userData: loginResponse
    var body: some View {
        
        Text(userData.username ?? "")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow)
        
        Text(userData.firstName ?? "")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow)
        
        Text(userData.lastName ?? "")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow)
    }
}
