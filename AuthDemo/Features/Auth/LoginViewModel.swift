//
//  LoginViewModel.swift
//  AuthDemo
//
//  Created by Ryan on 9/4/25.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    // Inputs
    @Published var username: String = ""
    @Published var password: String = ""

    // Outputs
    @Published private(set) var isLoginEnabled: Bool = false
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var isLoggedIn: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        Publishers.CombineLatest($username, $password)
            .map { !$0.trimmingCharacters(in: .whitespaces).isEmpty && $1.count >= 4 }
            .assign(to: \.isLoginEnabled, on: self)
            .store(in: &cancellables)
    }

    func login() {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        Task {
            defer { isLoading = false }
            do {
                try await AuthService.login(username: username, password: password)
                isLoggedIn = true   // notify VC directly
            } catch {
                errorMessage = error.localizedDescription
                isLoggedIn = false
            }
        }
    }
}
