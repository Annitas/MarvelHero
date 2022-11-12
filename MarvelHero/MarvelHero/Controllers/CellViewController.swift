//
//  ViewController.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 19.10.2022.
//

import UIKit

final class CellViewController: UIViewController {
    // MARK: cell sizes
    private let cellWidth = (3 / 4) * UIScreen.main.bounds.width
    private let cellHeight = (3 / 5) * UIScreen.main.bounds.height - 60
    private let sectionSpacing = (1 / 8) * UIScreen.main.bounds.width
    private let cellSpacing = (1 / 16) * UIScreen.main.bounds.width
    private let images: [String] = ["thor", "captainAmerica", "doctorStrange",
                            "groot", "ironMan", "spiderMan", "thanos"
    ]
    private let heroNames: [String] = ["Thor", "Captain America", "Dr Strange",
                            "Groot", "IronMan", "SpiderMan", "Thanos"
    ]
    private let heroInfo: [String] = ["Eat my hammer", "I'm just a kid from Brooklyn",
                              "Dormammu, I've come to bargain", "I am Groot",
                              "Give me a scotch. I'm starving",
                              "Hey kiddo, let mom and dad talk for a minute, will ya?",
                              "I don't even know who you are"
    ]
    private let colors: [CGColor] = [UIColor.systemRed.cgColor,
                             UIColor.systemBlue.cgColor,
                             UIColor.systemYellow.cgColor,
                             UIColor.systemBrown.cgColor,
                             UIColor.darkGray.cgColor,
                             UIColor.systemPink.cgColor,
                             UIColor.systemPurple.cgColor
    ]

    private lazy var collectionView: UICollectionView = {
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = cellSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.sharedInstance.getSmthFromInternet()
        createGradientLayer(bottomColor: 5)
        let logoName = "marvel"
        let marvelLogo = UIImage(named: logoName)
        let imageView = UIImageView(image: marvelLogo!)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        let chooseHeroLabel = UILabel()
        view.addSubview(chooseHeroLabel)
        chooseHeroLabel.font = UIFont.boldSystemFont(ofSize: 26)
        chooseHeroLabel.text = "Choose your hero"
        chooseHeroLabel.textColor = UIColor.white
        chooseHeroLabel.translatesAutoresizingMaskIntoConstraints = false
        chooseHeroLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        chooseHeroLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(handleTapGesture(_:)))
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "photoCell")
        view.addSubview(collectionView)
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: cellHeight).isActive = true
        collectionView.backgroundColor = .clear
        collectionView.addGestureRecognizer(gesture)
    }
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        guard let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
            return
        }
        let item = indexPath.item
        let heroInfo = HeroViewController(heroView: images[item], heroLabelName: heroNames[item],
                                          heroInfo: heroInfo[item])
        navigationController?.pushViewController(heroInfo, animated: true)
    }
    func createGradientLayer(bottomColor: Int) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemGray.cgColor, colors[bottomColor]]
        view.layer.addSublayer(gradientLayer)
    }
}

extension CellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CustomCell else {
            return .init()
        }
        let heroImage = images[indexPath.item]
        let heroLabel = heroNames[indexPath.item] // item.name
        cell.setupLayout(image: heroImage, label: heroLabel)
        return cell
    }
}
