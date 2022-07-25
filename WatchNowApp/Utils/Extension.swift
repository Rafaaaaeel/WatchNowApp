//
//  Extension.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//

import Foundation
import UIKit

//  MARK: - UIImageView
extension UIImageView{
    func loadImagefromUrl(url: String){
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

//  MARK: - UIViewController
extension UIViewController{
    func setStatusBar(){
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusBarView = UIView(frame: frame)
        
        
        statusBarView.backgroundColor = .systemBlue
        view.addSubview(statusBarView)
    }
    
    func setTabBarImage(imageName: String, title: String){
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}

//  MARK: - UIView
extension UIView {
    
    func setCellShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 10
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.layer.cornerRadius = 9
    }
    
}

//  MARK: - UICollectionViewLayout
extension UICollectionViewLayout{
    func createLayoutLandscape() -> UICollectionViewCompositionalLayout{
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .fractionalWidth(1/1.8)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .fractionalWidth(1/1.8)),
            subitem: item,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func createLayoutPortrait() -> UICollectionViewCompositionalLayout{
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            ),
            subitem: item,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}

//  MARK: - UITextField
let passwordTottleButton = UIButton(type: .custom)

extension UITextField {
    internal func addBottomBorder(height: CGFloat = 1.0, color: UIColor = .darkGray) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)
        NSLayoutConstraint.activate(
            [
                borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                borderView.heightAnchor.constraint(equalToConstant: height),
            ]
        )
    }
    
    
    func enablePasswordToggle(){
        passwordTottleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordTottleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordTottleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordTottleButton
        rightViewMode = .always
    }
    
    @objc
    func togglePasswordView(_ sender: Any){
        isSecureTextEntry.toggle()
        passwordTottleButton.isSelected.toggle()
    }
}

extension UIView{
    func addSubviews(_ subviews: UIView...){
        subviews.forEach(addSubview)
    }
}


