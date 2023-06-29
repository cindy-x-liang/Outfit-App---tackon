//
//  CustomCollectionViewHeader.swift
//  app2
//
//  Created by Cindy Liang on 6/10/23.
//

import UIKit

class CustomCollectionViewHeader: UICollectionReusableView {
 
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        addSubview(label)
        setupConstraints()
    }
    
    func configure(section: String) {
        label.text = section
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

