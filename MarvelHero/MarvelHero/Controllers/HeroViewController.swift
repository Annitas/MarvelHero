//
//  HeroInformationController.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 27.10.2022.
//

import UIKit

final class HeroViewController: UIViewController {
    private var heroInfoView: UIImageView = { // picture of a hero
        var heroView = UIImageView()
        heroView.clipsToBounds = true
        return heroView
    }()
    private let heroLabelName: UILabel = { // hero's name
        var heroLabel = UILabel()
        heroLabel.textColor = .white
        heroLabel.font = UIFont.boldSystemFont(ofSize: 22)
        return heroLabel
    }()
    private let heroInfo: UILabel = { // description of a hero
        var heroInfoView = UILabel()
        heroInfoView.textColor = .white
        heroInfoView.font = UIFont.boldSystemFont(ofSize: 22)
        return heroInfoView
    }()
    convenience init(heroView: String, heroLabelName: String, heroInfo: String) {
        self.init()
        let marvelImageName = UIImage(named: heroView)
        let marvelImage = UIImageView(image: marvelImageName)
        self.heroInfoView = marvelImage
        self.heroLabelName.text = heroLabelName
        self.heroInfo.text = heroInfo
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3

        view.addSubview(heroInfoView)
        heroInfoView.translatesAutoresizingMaskIntoConstraints = false
        heroInfoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        heroInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        heroInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        heroInfoView.layer.cornerRadius = 15

        view.addSubview(heroInfo)
        heroInfo.translatesAutoresizingMaskIntoConstraints = false
        heroInfo.leftAnchor.constraint(equalTo: heroInfoView.leftAnchor, constant: 20).isActive = true
        heroInfo.bottomAnchor.constraint(equalTo: heroInfoView.bottomAnchor, constant: -10).isActive = true

        heroLabelName.font = .boldSystemFont(ofSize: 28)
        view.addSubview(heroLabelName)
        heroLabelName.translatesAutoresizingMaskIntoConstraints = false
        heroLabelName.bottomAnchor.constraint(equalTo: heroInfoView.bottomAnchor, constant: -40).isActive = true
        heroLabelName.leftAnchor.constraint(equalTo: heroInfoView.leftAnchor, constant: 20).isActive = true

    }
}
