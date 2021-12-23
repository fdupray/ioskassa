//
//  SettingsViewModel.swift
//  ioskassa
//
//  Created by Frederick Dupray on 23/12/2021.
//

import Foundation
import Combine
import SwiftUI

struct StorageKeys {
    static let customURL = "customURL"
}

enum URLType: Int {
    case standard
    case custom
}

class SettingsViewModel: ObservableObject {
    
    var cancellables: Set<AnyCancellable> = []
    
    @Published var settingsText: String = ""
    @Published var selectedIndex: Int = 0
    
    @AppStorage(StorageKeys.customURL) var customURL: String?
    
    init() {
        subscribeToUpdates()
    }
    
    func subscribeToUpdates() {
        objectWillChange.sink { [weak self] in
            guard let self = self else { return }
            
            if let type = URLType(rawValue: self.selectedIndex),
               type == .custom {
                self.customURL = self.settingsText
            }
            else {
                if self.customURL != nil {
                    self.customURL = nil
                }
            }
        }
        .store(in: &cancellables)
    }
}
