//
//  HomeUI.swift
//  62academy
//
//  Created by NadiaWulandari on 30/07/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import SwiftUI
 
struct HomeUI: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Menu")
                .font(.largeTitle)
                .fontWeight(.bold)
 
            Spacer()
 
            Button(action: {
                // Aksi untuk tombol menu pertama
                print("Menu 1")
            }) {
                Text("Menu 1")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
 
            Button(action: {
                // Aksi untuk tombol menu kedua
                print("Menu 2")
            }) {
                Text("Menu 2")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
 
            Button(action: {
                // Aksi untuk tombol menu ketiga
                print("Menu 3")
            }) {
                Text("Menu 3")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
 
            Button(action: {
                // Aksi untuk tombol menu keempat
                print("Menu 4")
            }) {
                Text("Menu 4")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
            }
 
            Button(action: {
                // Aksi untuk tombol menu kelima
                print("Menu 5")
            }) {
                Text("Menu 5")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(10)
            }
 
            Button(action: {
                // Aksi untuk tombol menu keenam
                print("Menu 6")
            }) {
                Text("Menu 6")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
 
            Spacer()
        }
        .padding()
    }
}
 
struct HomeUI_Previews: PreviewProvider {
    static var previews: some View {
        HomeUI()
    }
}
