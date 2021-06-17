//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import UIKit
import RxSwift

class PokemonListViewController: UIViewController {
    
    // MARK: - Constants
    private let disposeBag = DisposeBag()
    
    // MARK: - Properties
    private lazy var viewModel: PokemonListViewModel = {
        PokemonListViewModel()
    }()
    
    private lazy var adapter: PokemonListAdapter = {
        PokemonListAdapter(delegate: self)
    }()
    
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
        viewModel.fetchPokemons()
    }
    
    // MARK: - Setup
    private func setupBindings() {
        viewModel.showLoadingIndicator
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: updateIsLoading)
            .disposed(by: disposeBag)
        
        viewModel.indexPathsToReload
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: updateTableView)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: presentErrorMessage)
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    // MARK: - Update
    private func updateIsLoading(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = isLoading ? 0 : 1
        }
    }
    
    private func updateTableView(_ indexPaths: [IndexPath]) {
        tableView.numberOfRows(inSection: 0) > 0
            ? tableView.reloadRows(at: visibleIndexPathsToReload(intersecting: indexPaths), with: .automatic)
            : tableView.reloadData()
    }
    
    // MARK: - Utils
    private func presentErrorMessage(_ message: String) {
        let alertCon = UIAlertController(title: "Opps..", message: message, preferredStyle: .alert)
        alertCon.addAction(.init(title: "OK", style: .default))
        present(alertCon, animated: true)
    }
    
    private func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
    // MARK: - Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.prefetchDataSource = adapter
        tableView.dataSource = adapter
        tableView.delegate = adapter
        tableView.alpha = 0
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        return activityIndicator
    }()
}

// MARK: - PokemonListProtocol
extension PokemonListViewController: PokemonListProtocol {
    func getItemAt(_ indexPath: IndexPath) -> PokemonListItem? {
        return viewModel.getItemAt(indexPath)
    }
    
    func getCurrentNumberOfItems() -> Int {
        return viewModel.currentNumberOfItems
    }
    
    func getTotalNumberOfItems() -> Int {
        return viewModel.totalNumberOfItems
    }
    
    func fetchNewItems() {
        viewModel.fetchPokemons()
    }
    
    func itemSelectedAt(_ indexPath: IndexPath) {
        if let item = viewModel.getItemAt(indexPath), UIApplication.shared.canOpenURL(item.url) {
            UIApplication.shared.open(item.url)
        } else {
            presentErrorMessage("Could not open link")
        }
    }
}
