//
//  WelcomeViewController.swift
//  AuthDemo
//
//  Created by Ryan on 9/4/25.
//
import UIKit
import SnapKit

final class WelcomeViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 50)
        label.textAlignment = .center
        label.text = "Welcome"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
