//
//  SongsCollectionViewCell.swift
//  TestMusicLibrary
//
//  Created by Panchenko Oleg on 10.07.2022.
//

import UIKit

class SongsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "SongsCollectionViewCell"
    
    let nameSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
        self.addSubview(nameSongLabel)
        NSLayoutConstraint.activate([
            nameSongLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor.self, constant: 5),
            nameSongLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            nameSongLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameSongLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
