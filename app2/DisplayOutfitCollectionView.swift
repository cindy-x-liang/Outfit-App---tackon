//
//  DisplayOutfitCollectionView.swift
//  app2
//
//  Created by Cindy Liang on 6/11/23.
//

import UIKit

class DisplayOutfitCollectionView: UICollectionViewCell {
    
    let label = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        
        setupConstraints()
    }
    
    func configure(clothes: Clothes) {
        label.image = clothes.imageName.image
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
    }
    
}
