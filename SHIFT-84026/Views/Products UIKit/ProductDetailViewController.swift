//
//  ProductDetailViewController.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 02.07.2025.
//

import UIKit


class ProductDetailViewController: UIViewController {
    private let product: Product
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let productImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    private let buyButton = UIButton(type: .system)
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        productImageView.contentMode = .scaleAspectFit
        productImageView.layer.cornerRadius = 10
        productImageView.clipsToBounds = true
        productImageView.backgroundColor = .white
        
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel
        
        priceLabel.font = .preferredFont(forTextStyle: .largeTitle)
        priceLabel.textColor = .systemBlue
        
        buyButton.setTitle("Купить", for: .normal)
        buyButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        buyButton.backgroundColor = .systemBlue
        buyButton.tintColor = .white
        buyButton.layer.cornerRadius = 10
        buyButton.clipsToBounds = true
        
        let stackView = UIStackView(arrangedSubviews: [
            productImageView,
            titleLabel,
            descriptionLabel,
            priceLabel,
            buyButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.setCustomSpacing(32, after: descriptionLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            productImageView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            buyButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureViews() {
        title = product.title
        
        if let url = URL(string: product.image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.productImageView.image = image
                    }
                }
            }.resume()
        }
        
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        priceLabel.text = String(format: "$%.2f", product.price)
    }
}
