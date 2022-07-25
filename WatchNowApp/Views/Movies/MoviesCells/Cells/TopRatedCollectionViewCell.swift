//
//  TopRatedCollectionViewCell.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//


import UIKit
import SkeletonView

class TopRatedCollectionViewCell: UICollectionViewCell, CodableViews {
    
    static let identifier = "TopRatedCollectionViewCell"
    
//  MARK: - UI Components
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        return image
    }()
    
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
//  MARK: Init
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
        self.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}

//  MARK: - View Functions

extension TopRatedCollectionViewCell{
    func setupHiearchy() {
        contentView.addSubview(imageView)
        addSubview(movieNameLabel)
        
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 0),
        ])
    }
    
    func additional() {
        contentView.clipsToBounds = true
    }
    
}

//  MARK: - View Model

extension TopRatedCollectionViewCell{
    func configure(with model: Movie){
        self.movieNameLabel.text = model.title
        self.imageView.loadImagefromUrl(url: model.backdropURL)
    }
}

