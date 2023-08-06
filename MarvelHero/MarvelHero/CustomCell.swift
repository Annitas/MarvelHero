//
//  CustomCell.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 19.10.2022.
//

import UIKit
import Kingfisher
import SnapKit

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
        setupConstraints()
    }
    func setupConstraints() {
        heroImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        heroImageView.layer.cornerRadius = 15
        heroLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(heroImageView.snp.bottom).offset(-10)
            make.left.equalTo(heroImageView.snp.left).offset(10)
        }
    }

    func setupCellView(image: String, label: String, heroData: Data?) {
        if image != "" {
            let url = URL(string: image)
            heroImageView.kf.setImage(with: url)
        } else {
            guard let data = heroData else { return }
            let image = UIImage(data: data)
            heroImageView.image = image
        }
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
