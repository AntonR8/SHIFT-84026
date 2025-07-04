//
//  ProductsViewController.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 02.07.2025.
//

import UIKit


class ProductsViewController: UIViewController {
    private let viewModel = ProductsViewModel()
    private var productsTableView: UITableView!
    private var loadingIndicator: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadProducts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.updateSessionService()
    }

    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Товары"
        productsTableView = UITableView()
        productsTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        productsTableView.dataSource = self
        productsTableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addAction(UIAction { [weak self] _ in
            self?.loadProducts()
            refreshControl.endRefreshing()
        }, for: .valueChanged)
        productsTableView.refreshControl = refreshControl

        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.hidesWhenStopped = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Выйти",
            primaryAction: UIAction { [weak self] _ in
                self?.showLogoutAlert()
            }
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Привет",
            primaryAction: UIAction { [weak self] _ in
                self?.showGreeting()
            }
        )
        
        view.addSubview(productsTableView)
        view.addSubview(loadingIndicator)
        
        productsTableView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            productsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func loadProducts() {
        Task {
            loadingIndicator.startAnimating()
            await viewModel.fetchProducts()
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    private func showLogoutAlert() {
        let alert = UIAlertController(
            title: "Вы точно хотите выйти?",
            message: "Все ваши данные будут удалены",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive) { _ in
            self.viewModel.logout()
        })
        
        present(alert, animated: true)
    }
    
    private func showGreeting() {
        let alert = UIAlertController(
            title: viewModel.greetingMessage,
            message: nil,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        viewModel.showGreeting = false
    }
}


extension ProductsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        cell.configure(with: viewModel.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = viewModel.products[indexPath.row]
        let detailVC = ProductDetailViewController(product: product)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
