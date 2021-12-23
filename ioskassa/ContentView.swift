//
//  ContentView.swift
//  ioskassa
//
//  Created by Frederick Dupray on 23/12/2021.
//

import SwiftUI
import SafariServices

struct ContentView: View {
    
    @State var navIsActive: Bool = false
    
    var viewModel = ContentViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("EHL KASSASYSTEM")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .bold()
                    .padding(.vertical, 64)
                    .foregroundColor(.white)
                
                Text("Välj vad vill göra")
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack (spacing: 8) {
                    
                    if let url = viewModel.customURL {
                        ButtonBox(text: "New account", url: URL(string: url)!)
                    }
                    else {
                        ButtonBox(text: "New account", url: URL(string: "https://ioskassa.ehl.nu/auto_install/auto.php")!)
                    }
                    
                    ButtonBox(text: "Login", url: URL(string: "https://ioskassa.ehl.nu/adm-ms/")!)
                    
                    ButtonBox(text: "EHL.nu", url: URL(string: "https://www.ehl.nu")!)
                }
                .padding(4)
                .frame(height: 50)
                .background(Color(uiColor: .black).opacity(0.6))
            }
            .background(Color(uiColor: .darkGray))
            
            NavigationLink(isActive: $navIsActive) {
                SettingsView()
            } label: {
                EmptyView()
            }
        }
        .navigationTitle("EHL.nu")
        .navigationBarItems(leading: Image("ehl_logo_utan_text", bundle: nil).frame(width: 22, height: 22), trailing: Image("settings", bundle: nil).onTapGesture {
            navIsActive = true
        })
    }
}

struct ButtonBox: View {
    
    let text: String
    let url: URL
    @State var isPresentingView: Bool = false
    
    var body: some View {
        
        Button(text) {
            isPresentingView = true
        }
        .sheet(isPresented: $isPresentingView) {
            isPresentingView = false
        } content: {
            SafariView(url: url)
        }
        .font(.system(size: 15))
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .foregroundColor(.white)
        .background(Color.black.opacity(0.8))
    }
}

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = SFSafariViewController(url: url)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
