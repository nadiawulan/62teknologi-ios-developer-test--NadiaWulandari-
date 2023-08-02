//
//  BitcoinView.swift
//  62academy
//
//  Created by NadiaWulandari on 01/08/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import SwiftUI

struct BitcoinPrice: Codable {
    let bpi: BPI
}

struct BPI: Codable {
    let USD: CurrencyInfo
}

struct CurrencyInfo: Codable {
    let rate: String
    let symbol: String
}

class BitcoinViewModel: ObservableObject {
    @Published var bitcoinRate: String = ""
    @Published var bitcoinSymbol: String = ""
    private let apiUrl = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!
    
    func fetchBitcoinPrice() {
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(BitcoinPrice.self, from: data)
                DispatchQueue.main.async {
                    self.bitcoinRate = decodedData.bpi.USD.rate
                    self.bitcoinSymbol = decodedData.bpi.USD.symbol
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct BitcoinView: View {
    @ObservedObject private var bitcoinViewModel = BitcoinViewModel()
    
    var body: some View {
        VStack {
            Text("View the Bitcoin Price")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Button(action: {
                self.bitcoinViewModel.fetchBitcoinPrice()
            }) {
                Text("Click Me")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Text("\(bitcoinViewModel.bitcoinSymbol) \(bitcoinViewModel.bitcoinRate)")
                .font(.title)
                .padding()
            
            Spacer()
        }
    }
}
