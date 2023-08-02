//
//  GenderPredictionView.swift
//  62academy
//
//  Created by NadiaWulandari on 02/08/23.
//  Copyright © 2023 62academyp. All rights reserved.
//

import SwiftUI

struct GenderPrediction: View {
    @State private var name: String = ""
    @State private var genderPrediction: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Gender Prediction by Your Name")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            TextField("Enter Your Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: predictGender) {
                Text("Click Me")
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            Text(genderPrediction)
                .padding()
        }
    }
    
    private func predictGender() {
        let name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !name.isEmpty else {
            showAlert(message: "Please Enter Your Name!")
            return
        }
        
        fetchGenderPrediction(for: name)
    }
    
    private func fetchGenderPrediction(for name: String) {
        let urlString = "https://api.genderize.io?name=\(name)"
        
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
                    let decoder = JSONDecoder()
                    let genderData = try decoder.decode(GenderData.self, from: data)
                    if let gender = genderData.gender, let probability = genderData.probability {
                        DispatchQueue.main.async {
                            let formattedProbability = String(format: "%.2f", probability * 100)
                            self.genderPrediction = "Prediction for \(name): \(gender) (\(formattedProbability)%)"
                        }
                    } else {
                        self.showAlert(message: "we cannot predict you gender \(name)")
                    }
                } catch {
                    self.showAlert(message: "we cannot proccess your data")
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

struct GenderData: Codable {
    let name: String?
    let gender: String?
    let probability: Double?
}

#if DEBUG
struct GenderPrediction_Previews: PreviewProvider {
    static var previews: some View {
        GenderPrediction()
    }
}
#endif
