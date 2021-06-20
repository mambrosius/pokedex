//
//  BaseViewController.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 18/06/2021.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    // MARK: - Constants
    let disposeBag = DisposeBag()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setupBindings()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackButton()
    }
    
    // MARK: - Setup
    func setupBindings() {
        
    }
    
    func setupUI() {
        view.backgroundColor = Asset.Color.grayBackground
    }
    
    private func setupBackButton() {
        guard let navigationStack = navigationController?.viewControllers else { return }
        
        let isRootViewController = navigationStack.count == 1
        navigationController?.setNavigationBarHidden(!isRootViewController, animated: true)
        
        guard !isRootViewController else { return }
        view.addSubview(backButton)
        backButton.setConstraints([
            .top(anchor: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            .leading(anchor: view.leadingAnchor, constant: 20),
            .width(constant: 30),
            .height(constant: 30)
        ])
    }
    
    // MARK: - Actions
    @objc private func backButtonTouched() {
        navigationController?.popViewController(animated: true)
    }
    
    // Components
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(Asset.Icon.arrowLeft?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(backButtonTouched), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Utils
    func presentErrorMessage(_ message: String) {
        let alertCon = UIAlertController(title: "Opps..", message: message, preferredStyle: .alert)
        alertCon.addAction(.init(title: "OK", style: .default))
        present(alertCon, animated: true)
    }
}
