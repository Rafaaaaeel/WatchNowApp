//
//  Popular.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//

import UIKit

internal class PopularCell: UICollectionViewCell, CodableViews, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MoviePresenterDelegate{
    
    static let identifier = "PopularCell"
    var movies: [Movie]?
    private let presenter = MoviePresenter()

//  MARK: - UI Components
    
    private lazy var popularTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popular"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout.createLayoutPortrait())
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
  
        cv.showsHorizontalScrollIndicator = false
        cv.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
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

internal extension PopularCell{
    func setupHiearchy() {
        addSubviews(collectionView,popularTitleLabel)
    }
    
    func setupContraints() {
        collectionView.frame = bounds
        
        NSLayoutConstraint.activate([
            popularTitleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -12),
            popularTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: collectionView.leadingAnchor, multiplier: 1)
        ])
    }
    
    func additional() {
        presenter.setViewDelegate(delegate: self)
        starLoading()
    }
}

//  MARK: - Collection Delegate & Data Source

internal extension PopularCell{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
        
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

internal extension PopularCell{
    
    func presentMovies(movies: [Movie]) async {
        self.movies = movies
    }

    func starLoading(){
        Task{
            await presenter.getMovies(endpoint: .popular)
            collectionView.reloadData()
        }
    }
    
}
