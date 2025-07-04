//
//  ProductTableViewCell.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 02.07.2025.
//

import UIKit


class ProductTableViewCell: UITableViewCell {
    private let productImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let categoryLabel = UILabel()
    private let ratingLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        productImageView.contentMode = .scaleAspectFit
        productImageView.backgroundColor = .white
        productImageView.layer.cornerRadius = 8
        productImageView.clipsToBounds = true
        
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 2
        
        priceLabel.font = .preferredFont(forTextStyle: .subheadline)
        priceLabel.textColor = .systemYellow
        
        categoryLabel.font = .preferredFont(forTextStyle: .caption1)
        categoryLabel.textColor = .secondaryLabel
        
        ratingLabel.font = .preferredFont(forTextStyle: .caption1)
        
        let infoStack = UIStackView(arrangedSubviews: [priceLabel, categoryLabel, ratingLabel])
        infoStack.spacing = 8
        infoStack.distribution = .fillProportionally
        
        let textStack = UIStackView(arrangedSubviews: [titleLabel, infoStack])
        textStack.axis = .vertical
        textStack.spacing = 4
        
        let mainStack = UIStackView(arrangedSubviews: [productImageView, textStack])
        mainStack.spacing = 16
        mainStack.alignment = .center
        
        contentView.addSubview(mainStack)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = String(format: "$%.2f", product.price)
        categoryLabel.text = product.category.capitalized
        ratingLabel.text = "\(product.rating.rate)"
        
        if let url = URL(string: product.image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.productImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
