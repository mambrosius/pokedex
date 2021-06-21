//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import UIKit
import RxSwift

class PokemonListViewController: BaseViewController {
    
    // MARK: - Properties
    private lazy var viewModel: PokemonListViewModel = {
        PokemonListViewModel()
    }()
    
    private lazy var adapter: PokemonListAdapter = {
        PokemonListAdapter(delegate: self)
    }()
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPokemonLinks()
    }
    
    // MARK: - Setup
    override func setupBindings() {
        super.setupBindings()
        
        viewModel.showLoadingIndicator
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: updateIsLoading)
            .disposed(by: disposeBag)
        
        viewModel.indexPathsToReload
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: updateTableView)
            .disposed(by: disposeBag)
        
        viewModel.reloadData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: updateTableView)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: presentErrorMessage)
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(card)
        
        card.setConstraints([
            .top(anchor: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            .leading(anchor: view.leadingAnchor, constant: 16),
            .trailing(anchor: view.trailingAnchor, constant: -16),
            .height(constant: 40)
        ])
                
        tableView.setConstraints([
            .top(anchor: view.topAnchor),
            .leading(anchor: view.leadingAnchor),
            .trailing(anchor: view.trailingAnchor),
            .bottom(anchor: view.bottomAnchor)
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
    
    private func updateTableView(_ reload: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Utils
    private func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
    // MARK: - Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.identifier)
        tableView.contentInset = .init(top: 56, left: 0, bottom: 16, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        (searchBar.value(forKey: "searchField") as? UITextField)?.backgroundColor = .clear
        searchBar.backgroundImage = .init()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var card: Card = {
        let card = Card(color: Asset.Color.grayCardInner, margin: 0, contentAxis: .horizontal)
        card.stackView.addArrangedSubview(searchBar)
        card.addDropShadow()
        return card
    }()
}

// MARK: - PokemonListProtocol
extension PokemonListViewController: PokemonListProtocol {
    func getItemAt(_ indexPath: IndexPath) -> Link? {
        return viewModel.getItemAt(indexPath)
    }
    
    func getCurrentNumberOfItems() -> Int {
        return viewModel.currentNumberOfItems
    }
    
    func getTotalNumberOfItems() -> Int {
        return viewModel.totalNumberOfItems
    }
    
    func fetchNewItems() {
        viewModel.fetchPokemonLinks()
    }
    
    func itemSelectedAt(_ indexPath: IndexPath) {
        guard let item = viewModel.getItemAt(indexPath), UIApplication.shared.canOpenURL(item.url) else { return }
        let pokemonDetailsViewController = PokemonDetailsViewController(viewModel: .init(pokemonLink: item))
        navigationController?.pushViewController(pokemonDetailsViewController, animated: true)
        hideKeyboard()
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UISearchBarDelegate
extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.performSearch(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
