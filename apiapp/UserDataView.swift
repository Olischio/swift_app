//
//  File.swift
//  apiapp
//
//  Created by Oliver Schiøtt on 31/03/2023.
//



import Foundation
import SwiftUI

struct UserDataView: View {
    var userData: loginResponse
    var body: some View {
        
        //Denne Koden viser frem BrukerData fra structen som dataen har blitt lagret i etter API kallet
        
        AsyncImage(url: userData.image) {image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
        
        
        Text(userData.username ?? "")
            .font(.largeTitle)
        
        Text(userData.firstName ?? "")
            .font(.largeTitle)
        
        
        Text(userData.lastName ?? "")
            .font(.largeTitle)
           
    }
}
