//
//  CustomCell.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 19.10.2022.
//

import UIKit
import Kingfisher

final class CustomCell: UICollectionViewCell {
    private let heroImageView: UIImageView = {
        let heroView = UIImageView()
        heroView.clipsToBounds = true
        return heroView
    }()
    private let heroLabel: UILabel = {
        let heroLabel = UILabel()
        heroLabel.textColor = .white
        heroLabel.font = UIFont.boldSystemFont(ofSize: 22)
        return heroLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addSubview(heroLabel)
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        heroImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        heroImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        heroImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        heroImageView.layer.cornerRadius = 15
        heroLabel.translatesAutoresizingMaskIntoConstraints = false
        heroLabel.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: -10).isActive = true
        heroLabel.leftAnchor.constraint(equalTo: heroImageView.leftAnchor, constant: 10).isActive = true
    }

    func setupLayout(image: String, label: String) {
//        if let image: UIImage = UIImage(named: image) {
//            heroImageView.image = image
//        }
        print("IN LAYOUT: \(image)")
        let url = URL(string: image)
        heroImageView.kf.setImage(with: url)
//        self.heroImageView.setImage(imageUrl: image)
        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = 5
        myShadow.shadowOffset = CGSize(width: 3, height: 2)
        myShadow.shadowColor = UIColor.black

        let myAttribute = [ NSAttributedString.Key.shadow: myShadow ]
        let myAttrString = NSAttributedString(string: label, attributes: myAttribute)
        heroLabel.attributedText = myAttrString
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
