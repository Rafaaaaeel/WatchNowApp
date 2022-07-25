//
//  TopRated.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//

import UIKit

class TopRatedCell: UICollectionViewCell, CodableViews, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MoviePresenterDelegate{
    
    static let identifier = "TopRatedCell"
    var movies: [Movie]?
    private let presenter = MoviePresenter()
    
//  MARK: - UI Components
    
    private lazy var topRatedTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Top Rated"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout.createLayoutLandscape())
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(TopRatedCollectionViewCell.self, forCellWithReuseIdentifier: TopRatedCollectionViewCell.identifier)
        return cv
    }()
    
//  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}

//  MARK: - View Functions

extension TopRatedCell{
    func setupHiearchy() {
        addSubviews(collectionView,topRatedTitleLabel)
    }
    
    func setupContraints() {
        collectionView.frame = bounds
        
        NSLayoutConstraint.activate([
            topRatedTitleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -12),
            topRatedTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: collectionView.leadingAnchor, multiplier: 1)
        ])
    }
    
    func additional() {
        presenter.setViewDelegate(delegate: self)
        starLoading()
    }
}

//  MARK: - Collection Delegate & Data Source

extension TopRatedCell{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCollectionViewCell.identifier, for: indexPath) as! TopRatedCollectionViewCell
        guard let movies = self.movies else { return cell}
        
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
}

//  MARK: Network api call

extension TopRatedCell{
    func presentMovies(movies: [Movie]) async {
        self.movies = movies
    }

    func starLoading(){
        Task{
            await presenter.getMovies(endpoint: .topRated)
            collectionView.reloadData()
        }
    }
}
