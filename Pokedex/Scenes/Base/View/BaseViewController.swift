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
        view.backgroundColor = Color.grayBackground
    }
    
    private func setupBackButton() {
        guard let navigationStack = navigationController?.viewControllers, navigationStack.count > 1 else { return }
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Icon.arrowLeft, style: .plain, target: self, action: #selector(backButtonTouched))
    }
    
    // MARK: - Actions
    @objc private func backButtonTouched() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Utils
    func presentErrorMessage(_ message: String) {
        let alertCon = UIAlertController(title: "Opps..", message: message, preferredStyle: .alert)
        alertCon.addAction(.init(title: "OK", style: .default))
        present(alertCon, animated: true)
    }
}
