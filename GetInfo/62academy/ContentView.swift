//
//  ContentView.swift
//  62academy
//
//  Created by NadiaWulandari on 30/07/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import SwiftUI
 
struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: CatFactView()) {
                    Text("Random Cat Fact")
                }
                NavigationLink(destination: GenderPrediction()) {
                    Text("Gender Prediction byy Your Name")
                }
                NavigationLink(destination: JokeView()) {
                    Text("Random Jokes")
                }
                NavigationLink(destination: AgePrediction()) {
                    Text("Age Prediction by Your Name")
                }
                NavigationLink(destination: BitcoinView()) {
                    Text("The Bitcoin Price")
                }
                NavigationLink(destination: IPInfoView()) {
                    Text("IP Info")
                }
            }
            .navigationBarTitle("Menu")
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
