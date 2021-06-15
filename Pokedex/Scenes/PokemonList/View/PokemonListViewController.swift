//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import UIKit

class PokemonListViewController: UIViewController {

    // MARK: - Properties
    lazy var viewModel: PokemonListViewModel = {
        PokemonListViewModel(delegate: self)
    }()
    
    lazy var adapter: PokemonListAdapter = {
        PokemonListAdapter(delegate: self)
    }()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPokemons()
    }
    
    // MARK: - Setup
    private func setup() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Components
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = adapter
        tableView.delegate = adapter
        tableView.alpha = 0
        return tableView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        return activityIndicator
    }()
    
    // MARK: - Utils
    private func presentAlertWith(title: String, message: String) {
        let alertCon = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertCon.addAction(.init(title: "OK", style: .default))
        present(alertCon, animated: true)
    }
}

// MARK: - PokemonListViewModelDelegate
extension PokemonListViewController: PokemonListViewModelDelegate {
    func updateSpinner(_ isLoading: Bool) {
        DispatchQueue.main.async {
            isLoading
                ? self.activityIndicator.startAnimating()
                : self.activityIndicator.stopAnimating()
            UIView.animate(withDuration: 0.2) {
                self.tableView.alpha = isLoading ? 0 : 1
            }
        }
    }
    
    func showErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            self.presentAlertWith(title: "Opps..", message: message)
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - PokemonListProtocol
extension PokemonListViewController: PokemonListProtocol {
    func getItemAt(_ indexPath: IndexPath) -> PokemonListItem {
        return viewModel.getItemAt(indexPath)
    }
    
    func getNumberOfItems() -> Int {
        return viewModel.numberOfItems
    }
    
    func itemSelectedAt(_ indexPath: IndexPath) {
        let url = viewModel.getItemAt(indexPath).url
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            presentAlertWith(title: "Opps...", message: "Could not open link")
        }
    }
}
