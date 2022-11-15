//
//  ViewController.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 19.10.2022.
//

import UIKit
import SnapKit

final class CellViewController: UIViewController {
    // MARK: cell sizes
    private let cellWidth = (3 / 4) * UIScreen.main.bounds.width
    private let cellHeight = (3 / 5) * UIScreen.main.bounds.height - 60
    private let sectionSpacing = (1 / 8) * UIScreen.main.bounds.width // need
    private let cellSpacing = (1 / 16) * UIScreen.main.bounds.width
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
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        return collectionView
    }()

    private let imageView = UIImageView(image: UIImage(named: "marvel"))
    private let chooseHeroLabel = UILabel()
    var apiResult = [Character]()
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.sharedInstance.getMarvelHeroes { apiData in
            self.apiResult = apiData
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        createGradientLayer(bottomColor: 5)
        view.addSubview(imageView)
        view.addSubview(chooseHeroLabel)
        chooseHeroLabel.font = UIFont.boldSystemFont(ofSize: 26)
        chooseHeroLabel.text = "Choose your hero"
        chooseHeroLabel.textColor = UIColor.white
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(handleTapGesture(_:)))
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "photoCell")
        view.addSubview(collectionView)
        // MARK: set constraints
        setupConstraints()
        collectionView.backgroundColor = .clear
        collectionView.addGestureRecognizer(gesture)
        collectionView.contentMode = .scaleAspectFill
        collectionView.clipsToBounds = true
    }
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        guard let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
            return
        }
        let heroLabel = apiResult[indexPath.row].name ?? ""
        let heroInf = apiResult[indexPath.row].description ?? ""
        var heroStr = "\(apiResult[indexPath.row].thumbnail?.path ?? "").\(apiResult[indexPath.row].thumbnail?.ext! ?? "")"
        heroStr.insert(contentsOf: "s", at: heroStr.index(heroStr.startIndex, offsetBy: 4))
        let heroInfo = HeroViewController(heroView: heroStr, heroLabelName: heroLabel, heroInfo: heroInf)
        navigationController?.pushViewController(heroInfo, animated: true)
    }
    func createGradientLayer(bottomColor: Int) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemGray.cgColor, colors[bottomColor]]
        view.layer.addSublayer(gradientLayer)
    }
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        chooseHeroLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(chooseHeroLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.80).offset(-70)
        }
    }
}

extension CellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiResult.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CustomCell else {
            return .init()
        }
        var heroStr = "\(apiResult[indexPath.row].thumbnail?.path ?? "")/portrait_uncanny.\(apiResult[indexPath.row].thumbnail?.ext! ?? "")"
        heroStr.insert(contentsOf: "s", at: heroStr.index(heroStr.startIndex, offsetBy: 4))
        let heroLabel = apiResult[indexPath.row].name ?? ""
        cell.setupLayout(image: heroStr, label: heroLabel)
        return cell
    }
}
