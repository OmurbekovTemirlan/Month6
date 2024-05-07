//
//  AuthenticationService.swift
//  myCofeHomeApp
//
//  Created by Apple on 6.5.2024.
//

import Foundation
import FirebaseAuth

struct AuthenticationService {
    
    private let auth = Auth.auth()
    
    func signIn(with phone: String, complition: @escaping (Result<Void, Error>) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { verificationId, error in
            if let verificationId {
                UserDefaults.standard.set(verificationId, forKey: "vID")
                complition(.success(()))
            }
            if let error {
                complition(.failure(error))
            }
        }
    }
    
    func verifyPhone(with code: String,
                     complition: @escaping (Result<AuthDataResult, Error>) -> Void ) {
        if let verificationId = UserDefaults.standard.string(forKey: "vID") {
            let credintionals = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationId,
                verificationCode: code)
            
            auth.signIn(with: credintionals) { data, error in
                if let error {
                    complition(.failure(error))
                }
                if let data {
                    complition(.success(data))
                }
            }
        }
    }
    
    func signIn(with email: String,
                password: String,
                complition: @escaping (Result<AuthDataResult, Error>) -> Void ) {
        
        auth.signIn(withEmail: email, password: password) { data, error in
            if let error {
                complition(.failure(error))
            }
            if let data {
                complition(.success(data))
            }
        }
         
    }
}
