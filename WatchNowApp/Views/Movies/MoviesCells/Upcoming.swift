//
//  Upcoming.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//

import UIKit

internal class UpcomingCell: UICollectionViewCell, CodableViews, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MoviePresenterDelegate{

    
    
    static let identifier = "UpcomingCell"
    private var movies: [Movie]?
    private let presenter = MoviePresenter()
    
//  MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout.createLayoutLandscape())
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(UpcomingCollectionViewCell.self, forCellWithReuseIdentifier: UpcomingCollectionViewCell.identifier)
        return cv
    }()
    
    private lazy var upcomingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Upcoming"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
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

internal extension UpcomingCell{
    func setupHiearchy() {
        addSubviews(collectionView,upcomingTitleLabel)
    }
    
    func setupContraints() {
        collectionView.frame = bounds
        
        NSLayoutConstraint.activate([
            upcomingTitleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -12),
            upcomingTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: collectionView.leadingAnchor, multiplier: 1)
        ])
    }
    
    func additional() {
        presenter.setViewDelegate(delegate: self)
        starLoading()
    }
}

//  MARK: - Collection Delegate & Data Source

internal extension UpcomingCell{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.identifier, for: indexPath) as! UpcomingCollectionViewCell
        
        guard let movies = self.movies else { return cell }
        
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 14, bottom: 0, right: 14)
    }
    
}

//  MARK: Network api call
internal extension UpcomingCell{

    func presentMovies(movies: [Movie]) async {
        self.movies = movies
    }

    func starLoading(){
        Task{
            await presenter.getMovies(endpoint: .upcoming)
            collectionView.reloadData()
        }
    }
    
}
