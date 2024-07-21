//
//  ContentView.swift
//  Swift message encrypter
//
//  Created by Noah Moller on 21/7/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var encrypt: EncryptModel
    @State private var input = ""
    var body: some View {
        VStack {
            TextField ("Input data", text: $input)
            
            Button {
                encrypt.example(data: input)
                print(encrypt.DecryptedData)
            }label: {
                Text("Encrypt")
            }
        }
        .padding()
    }
}
