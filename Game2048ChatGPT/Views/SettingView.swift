//
//  FilterFlights.swift
//  Enroute
//
//  Created by CS193p Instructor.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import SwiftUI

struct SettingView: View {
   
    @Binding var settings: Settings
    @Binding var isPresented: Bool
    
    @State private var draft: Settings
    
    init(settings: Binding<Settings>, isPresented: Binding<Bool>) {
        _settings = settings
        _isPresented = isPresented
        _draft = .init(wrappedValue: settings.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Monte Carlo")) {
                    Picker("Number Of Simulations", selection: $draft.numberSimulations) {
                        ForEach([100, 150, 180, 200], id: \.self) { number in
                            Text("\(number)").tag("\(number)")
                        }
                    }
                    Picker("Deep", selection: $draft.deep) {
                        ForEach([ 10, 15, 20], id: \.self) { deep in
                            Text("\(deep)").tag("\(deep)")
                        }
                    }
                    Picker("Limit Zeros", selection: $draft.limitZeros) {
                        ForEach([4, 5, 6, 7, 8], id: \.self) { limit in
                            Text("\(limit)").tag("\(limit)")
                        }
                    }
                    Picker("Zeros Weight MC", selection: $draft.zerosWeightMC) {
                        ForEach([1024, 2048, 4096, 8192, 16384], id: \.self) { weightMC in
                            Text("\(weightMC)").tag("\(weightMC)")
                        }
                    }
                }
                Section(header: Text("Tree Search")) {
                    Picker("Zeros Weight", selection: $draft.zerosWeight) {
                        ForEach([2.7, 5.7, 8.7, 11.7, 13.7], id: \.self) { weight in
                            Text("\(weight)").tag("\(weight)")
                        }
                    }
                    Picker("Zeros Beginning", selection: $draft.zerosBeginning) {
                        ForEach([4, 5, 6, 7], id: \.self) { beginnig in
                            Text("\(beginnig)").tag("\(beginnig)")
                        }
                    }
                  
                }
                Button(action: {draft.reset()}) {
                     Text("Reset")
                        .frame(maxWidth: .infinity)
                        .font(.system(.title2, design: .rounded))
                         .padding(.vertical, 9)
                         .background(Color.colorBG)//background(.gray) //Color.colorBG_2048)
                         .foregroundColor(.white)
                         .cornerRadius(4)
                     }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {cancel}
                ToolbarItem(placement: .navigationBarTrailing) {done}
             }
        }
    }
    
    var cancel: some View {
        Button("Cancel") {
            self.isPresented = false
        }
    }
    
    var done: some View {
        Button("Done") {
            self.settings = self.draft
            self.settings.updateConstants()
            self.isPresented = false
        }
    }
}

#Preview {
    SettingView(settings: .constant(Settings()), isPresented: .constant(false))
}
