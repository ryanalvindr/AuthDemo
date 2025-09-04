//
//  AuthService.swift
//  AuthDemo
//
//  Created by Ryan on 9/4/25.
//
import Foundation

enum AuthError: LocalizedError {
    case invalid
    var errorDescription: String? { "Invalid username or password" }
}

struct AuthService {
    static func login(username: String, password: String) async throws {
        // Simulate network latency (like waiting for a server response)
        try await Task.sleep(nanoseconds: 1000000000) // 1s delay
        
        // Hardcoded valid users
        let validUsers = [
            "ryan": "password1",
            "testuser2": "qwerty",
            "testuser3": "1234"
        ]
        
        if validUsers[username.lowercased()] == password {
            return  // success
        } else {
            throw AuthError.invalid
        }
    }
}
