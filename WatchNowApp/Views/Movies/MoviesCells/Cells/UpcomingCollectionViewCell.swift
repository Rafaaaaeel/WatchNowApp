//
//  UpcomingCollectionViewCell.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//


import UIKit
import SkeletonView

class UpcomingCollectionViewCell: UICollectionViewCell, CodableViews {
    
    static let identifier = "UpcomingCollectionViewCell"

//  MARK: - UI Components
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        return image
    }()
    
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie title Test"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
//  MARK: - Init
    
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

extension UpcomingCollectionViewCell{
    func setupHiearchy() {
        contentView.addSubview(imageView)
        addSubview(movieNameLabel)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 0),
            movieNameLabel.widthAnchor .constraint(equalToConstant: 300)
        ])
    }
    
    func additional() {
        contentView.clipsToBounds = true
    }
}

//  MARK: View Model

extension UpcomingCollectionViewCell{
    func configure(with model: Movie){
        self.movieNameLabel.text = model.title
        self.imageView.loadImagefromUrl(url: model.backdropURL)
    }
}

