//
//  AlbumsTableViewCell.swift
//  TestMusicLibrary
//
//  Created by Panchenko Oleg on 10.07.2022.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {
    
    static let reuseId = "AlbumsTableViewCell"
    
    private let albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Album name"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.text = "Artist name"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let trackCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.text = "Tracks"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    var stackView = UIStackView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        albumLogo.layer.cornerRadius = 6
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumLogo.image = nil
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        trackCountLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.addSubview(albumLogo)
        self.addSubview(albumNameLabel)
        
        stackView = UIStackView(arrangedSubviews: [artistNameLabel, trackCountLabel],
                                axis: .horizontal,
                                spacing: 10,
                                distribution: .equalCentering)
        self.addSubview(stackView)
    }
    
    func configureAlbumCell(album: Album) {
        
        if let urlString = album.artworkUrl100 {
            NetworkRequest.shared.requestData(urlString: urlString) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumLogo.image = image
                case .failure(let error):
                    self?.albumLogo.image = nil
                    print("No album logo" + error.localizedDescription)
                }
            }
        } else {
            albumLogo.image = nil
        }
        
        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        trackCountLabel.text = "\(album.trackCount) tracks"
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            albumLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            albumLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            albumLogo.widthAnchor.constraint(equalToConstant: 60),
            albumLogo.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            albumNameLabel.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 10),
            albumNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            albumNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
