//
//  UniversityListView.swift
//  62academy
//
//  Created by NadiaWulandari on 02/08/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import SwiftUI

struct  AgePrediction: View {
    @State private var name: String = ""
    @State private var prediction: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Prediksi Umur Berdasarkan Nama")
                .font(.title)
            
            TextField("Masukkan nama Anda", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: predictAge) {
                Text("Prediksi")
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            Text(prediction)
                .padding()
        }
    }
    
    private func predictAge() {
        let name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !name.isEmpty else {
            showAlert(message: "Silakan masukkan nama Anda")
            return
        }
        
        fetchAgePrediction(for: name)
    }
    
    private func fetchAgePrediction(for name: String) {
        let urlString = "https://api.agify.io?name=\(name)"
        
        guard let url = URL(string: urlString) else {
            showAlert(message: "URL tidak valid")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.showAlert(message: "Terjadi kesalahan: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let age = json?["age"] as? Int {
                        DispatchQueue.main.async {
                            self.prediction = "\(name) mungkin berusia sekitar \(age) tahun."
                        }
                    } else {
                        self.showAlert(message: "Tidak dapat memprediksi umur untuk nama \(name)")
                    }
                } catch {
                    self.showAlert(message: "Terjadi kesalahan dalam memproses data")
                }
            }
        }.resume()
    }
    
    private func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}

#if DEBUG
struct AgePrediction_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
