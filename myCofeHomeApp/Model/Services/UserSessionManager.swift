//
//  UserSessionManager.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//

import UIKit

final class UserSessionManager {
    
    static let shared = UserSessionManager()
    
    private init() { }

    var isSessionActive: Bool {
       
        let currentDate = Date()
        guard let sessionDate = UserDefaults.standard.object(forKey: "sessionDate") as? Date else { return false }
        
        return sessionDate < currentDate
    }
    
    func saveSession(phoneNumber: String) {
        
        if phoneNumber == "502030422" {
            print("Session is saved")
            let currentDate = Date()
            let thirySecondAfter = Calendar.current.date(
                byAdding: .second,
                value: 30,
                to: currentDate)
            UserDefaults.standard.setValue(thirySecondAfter, forKey: "sessionDate")
        } else {
            print("The data is't correct")
        }
    }
    
    func isValid(phoneNumber: String) -> Bool {
        let phoneNumberWithoutSpaces = phoneNumber.replacingOccurrences(of: " ", with: "")
        let phoneNumber = "502030422"
        return phoneNumber == "502030422" && phoneNumberWithoutSpaces.count == 9 && phoneNumberWithoutSpaces.allSatisfy { $0.isNumber }
       
    }
}
