//
//  HeroInformationController.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 27.10.2022.
//

import UIKit

final class HeroViewController: UIViewController {
    private var heroImageView: UIImageView = {
        var heroView = UIImageView()
        heroView.clipsToBounds = true
        return heroView
    }()
    private let heroLabelName: UILabel = {
        var heroLabel = UILabel()
        heroLabel.textColor = .white
        heroLabel.font = UIFont.boldSystemFont(ofSize: 22)
        return heroLabel
    }()
    private let heroInfo: UILabel = {
        var heroInfoView = UILabel()
        heroInfoView.textColor = .white
        heroInfoView.font = UIFont.boldSystemFont(ofSize: 22)
        return heroInfoView
    }()
    convenience init(heroView: String, heroLabelName: String, heroInfo: String) {
        self.init()
        let url = URL(string: heroView)
        self.heroImageView.kf.setImage(with: url)
        self.heroLabelName.text = heroLabelName
        self.heroInfo.text = heroInfo
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3

        view.addSubview(heroImageView)
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        heroImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        heroImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        heroImageView.layer.cornerRadius = 15

        view.addSubview(heroInfo)
        heroInfo.translatesAutoresizingMaskIntoConstraints = false
        heroInfo.leftAnchor.constraint(equalTo: heroImageView.leftAnchor, constant: 20).isActive = true
        heroInfo.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: -10).isActive = true

        heroLabelName.font = .boldSystemFont(ofSize: 28)
        view.addSubview(heroLabelName)
        heroLabelName.translatesAutoresizingMaskIntoConstraints = false
        heroLabelName.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: -40).isActive = true
        heroLabelName.leftAnchor.constraint(equalTo: heroImageView.leftAnchor, constant: 20).isActive = true
    }
}
