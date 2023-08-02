//
//  IPInfoView.swift
//  62academy
//
//  Created by NadiaWulandari on 01/08/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import SwiftUI

struct IPInfo: Codable {
    let ip: String
    let city: String
    let region: String
    let country: String
}

class IPInfoViewModel: ObservableObject {
    @Published var ip: String = ""
    @Published var city: String = ""
    @Published var region: String = ""
    @Published var country: String = ""
    private let apiUrl = URL(string: "https://ipinfo.io/161.185.160.93/geo")!
    
    func fetchIPInfo() {
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(IPInfo.self, from: data)
                DispatchQueue.main.async {
                    self.ip = decodedData.ip
                    self.city = decodedData.city
                    self.region = decodedData.region
                    self.country = decodedData.country
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct IPInfoView: View {
    @ObservedObject private var ipInfoViewModel = IPInfoViewModel()
    
    var body: some View {
        VStack {
            Text("Get IP Info")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Button(action: {
                self.ipInfoViewModel.fetchIPInfo()
            }) {
                Text("Click Me")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Text("IP Address: \(ipInfoViewModel.ip)")
                .padding()
            Text("City: \(ipInfoViewModel.city)")
                .padding()
            Text("Region: \(ipInfoViewModel.region)")
                .padding()
            Text("Country: \(ipInfoViewModel.country)")
                .padding()
            
            Spacer()
        }
    }
}
