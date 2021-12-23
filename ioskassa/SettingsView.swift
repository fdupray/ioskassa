//
//  SettingsView.swift
//  ioskassa
//
//  Created by Frederick Dupray on 23/12/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel = SettingsViewModel()
    
    @State var selectedIndex: Int = 0
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Text("EHL KASSASYSTEM")
                .foregroundColor(.white)
                .font(.system(size: 25))
                .bold()
                .padding(.bottom, 64)
            
            Text("Settings - login link")
                .foregroundColor(.white)
                .padding(.bottom, 24)
            
            VStack (alignment: .leading, spacing: 24) {
                
                HStack {
                    
                    Checkbox(isSelected: selectedIndex == 0)
                        .onTapGesture {
                            selectedIndex = 1
                        }
                    
                    Text("Standard login")
                        .foregroundColor(.white)
                }
                
                HStack {
                    
                    Checkbox(isSelected: selectedIndex == 1)
                        .onTapGesture {
                            selectedIndex = 0
                        }
                    
                    Text("Custom URL")
                        .foregroundColor(.white)
                    
                    TextField("Enter URL", text: $viewModel.settingsText, prompt: nil)
                        .background(Color.white)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color(uiColor: .darkGray))
        .navigationTitle("Settings")
    }
}

struct Checkbox: View {
    
    var isSelected: Bool
    
    @State var color: Color = .white
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 20, height: 20, alignment: .center)
                .border(Color.blue, width: 1)
                .foregroundColor(color)
                .cornerRadius(5)
                .onChange(of: isSelected) { newValue in
                    color = isSelected ? Color.blue : Color.white
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
