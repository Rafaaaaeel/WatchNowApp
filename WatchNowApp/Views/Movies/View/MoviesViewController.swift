//
//  MoviesViewController.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//

import Foundation
import UIKit


internal class MoviesViewController: UIViewController, CodableViews, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate      {

//  MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.register(NowPlayingCell.self, forCellWithReuseIdentifier: NowPlayingCell.identifier)
        cv.register(UpcomingCell.self, forCellWithReuseIdentifier: UpcomingCell.identifier)
        cv.register(TopRatedCell.self, forCellWithReuseIdentifier: TopRatedCell.identifier)
        cv.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.identifier)
        return cv
    }()

//  MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        setup()
    }
    
}


//  MARK: - Setup Function

extension MoviesViewController{
    func setupHiearchy() {
        view.addSubview(collectionView)
    }
    
    func setupContraints() {
        collectionView.frame = view.bounds
    }
    
}


//  MARK: - Collection View Delegate & Data Source

extension MoviesViewController{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCell.identifier, for: indexPath) as! UpcomingCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCell.identifier, for: indexPath) as! TopRatedCell
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.identifier, for: indexPath) as! PopularCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCell.identifier, for: indexPath) as! NowPlayingCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section{
        case 1:
            return CGSize(width: view.frame.width , height: 190)
        case 2:
            return CGSize(width: view.frame.width , height: 190)

        default:
            return CGSize(width: view.frame.width , height: 320)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 60, left: 0, bottom: 20, right: 0)
    }
}

