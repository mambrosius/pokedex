//
//  NavigationController.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 18/06/2021.
//

import UIKit

class NavigationController: UINavigationController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func setup() {
        navigationBar.barTintColor = Color.grayBackground
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
}
