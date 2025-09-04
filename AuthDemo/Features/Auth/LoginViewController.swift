//
//  ViewController.swift
//  AuthDemo
//
//  Created by Ryan on 9/4/25.
//

import UIKit
import SnapKit
import Combine

final class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 12
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.text = "Login"
        return label
    }()
    
    private let loginBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    private let userNameTxtField: UITextField = {
        let txtField = UITextField()
        txtField.layer.borderColor = UIColor(red: 0.322, green: 0.792, blue: 0.961, alpha: 1).cgColor
        txtField.layer.borderWidth = 1
        txtField.borderStyle = .roundedRect
        txtField.placeholder = "Username"
        return txtField
    }()
    
    private let passwordTxtField: UITextField = {
        let txtField = UITextField()
        txtField.layer.borderColor = UIColor(red: 0.322, green: 0.792, blue: 0.961, alpha: 1).cgColor
        txtField.layer.borderWidth = 1
        txtField.borderStyle = .roundedRect
        txtField.placeholder = "Password"
        txtField.isSecureTextEntry = true
        return txtField
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.isHidden = true
        spinner.color = .systemGray
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        setupHierarchy()
        setupLayout()
        bindViewModel()
        
        loginBtn.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        userNameTxtField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    func setupHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(userNameTxtField)
        stackView.addArrangedSubview(passwordTxtField)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(loginBtn)
        stackView.addArrangedSubview(spinner)
    }
    
    func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        userNameTxtField.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
        
        passwordTxtField.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
        
        loginBtn.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
    }
    
    private func bindViewModel() {
        viewModel.$isLoginEnabled
            .sink { [weak self] enabled in
                self?.loginBtn.isEnabled = enabled
                self?.loginBtn.alpha = enabled ? 1.0 : 0.5
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .sink { [weak self] loading in
                if loading {
                    self?.spinner.isHidden = false
                    self?.spinner.startAnimating()
                } else {
                    self?.spinner.stopAnimating()
                    self?.spinner.isHidden = true
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .sink { [weak self] msg in
                self?.errorLabel.text = msg
                self?.errorLabel.isHidden = (msg == nil)
            }
            .store(in: &cancellables)
        
        viewModel.$isLoggedIn
            .sink { [weak self] loggedIn in
                if loggedIn {
                    let welcomeVC = WelcomeViewController()
                    self?.navigationController?.pushViewController(welcomeVC, animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
    
    @objc private func textChanged() {
        viewModel.username = userNameTxtField.text ?? ""
        viewModel.password = passwordTxtField.text ?? ""
    }
    
    @objc private func didTapLogin() {
        viewModel.login()
    }
    
}

