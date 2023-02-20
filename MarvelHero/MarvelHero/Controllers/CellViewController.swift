//
//  ViewController.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 19.10.2022.
//

import UIKit
import SnapKit
import RealmSwift
import Kingfisher

final class CellViewController: UIViewController {
    private let marvelImageView = UIImageView(image: UIImage(named: "marvel"))
    private let backGroundImageView = BackgroundLayer(frame: .zero)
    private let chooseHeroLabel: UILabel = {
        let chooseHero = UILabel()
        chooseHero.font = UIFont.boldSystemFont(ofSize: 26)
        chooseHero.text = "Choose your hero"
        chooseHero.textColor = UIColor.white
        return chooseHero
    }()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: (1 / 8) * UIScreen.main.bounds.width,
                                           bottom: 0,
                                           right: (1 / 8) * UIScreen.main.bounds.width)
        layout.itemSize = CGSize(width: (3 / 4) * UIScreen.main.bounds.width,
                                 height: (3 / 5) * UIScreen.main.bounds.height - 60)
        layout.minimumLineSpacing = (1 / 16) * UIScreen.main.bounds.width
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        collectionView.contentMode = .scaleAspectFill
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .clear
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "photoCell")
        return collectionView
    }()
    private let backgroundColors: [UIColor] = [UIColor.systemRed,
                             UIColor.systemBlue,
                             UIColor.systemYellow,
                             UIColor.systemBrown,
                             UIColor.darkGray,
                             UIColor.systemPink,
                             UIColor.systemPurple
    ]

    private let dbManager: DBManager = DBManagerImpl()
    private var models = [HeroSet]()
    private var apiResult = [Character]()
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.sharedInstance.getMarvelHeroes { apiData in
            self.apiResult = apiData
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        view.addSubview(spinner)
        view.addSubview(backGroundImageView)
        backGroundImageView.setTriangleColor(backgroundColors[0])
//        createGradientLayer(bottomColor: 5)
        view.addSubview(marvelImageView)
        view.addSubview(chooseHeroLabel)
        view.addSubview(collectionView)
        setupCollectionView()
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(handleTapGesture(_:)))
        spinner.startAnimating()
        // MARK: set constraints
        setupConstraints()
        collectionView.addGestureRecognizer(gesture)
        self.models = self.dbManager.obtainHeroes()
        print(models)
    }
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        guard let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
            return
        }
        if !apiResult.isEmpty {
            let heroLabel = apiResult[indexPath.row].name ?? models.first?.heroes[indexPath.row].name ?? ""
            let heroInf = apiResult[indexPath.row].description ?? models.first?.heroes[indexPath.row].descriptionHero ?? ""
            var heroStr = "\(apiResult[indexPath.row].thumbnail?.path ?? "").\(apiResult[indexPath.row].thumbnail?.ext! ?? "")"
            heroStr.insert(contentsOf: "s", at: heroStr.index(heroStr.startIndex, offsetBy: 4))
            let heroImageData = models.first?.heroes[indexPath.row].pictureHero
            let heroInfo = HeroViewController(heroView: heroStr,
                                              heroLabelName: heroLabel,
                                              heroInfo: heroInf, heroImageData: heroImageData)
            navigationController?.pushViewController(heroInfo, animated: true)
        } else if !models.isEmpty {
            let heroLabel =  models.first?.heroes[indexPath.row].name ?? ""
            let heroInf = models.first?.heroes[indexPath.row].descriptionHero ?? ""
            let heroStr = ""
            let heroImageData = models.first?.heroes[indexPath.row].pictureHero
            let heroInfo = HeroViewController(heroView: heroStr,
                                              heroLabelName: heroLabel,
                                              heroInfo: heroInf, heroImageData: heroImageData)
            navigationController?.pushViewController(heroInfo, animated: true)
        }
    }
    private func setupCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self.collectionView.alpha = 1
            }
        })
    }
    func createGradientLayer(bottomColor: Int) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemGray.cgColor, backgroundColors[bottomColor]]
        view.layer.addSublayer(gradientLayer)
    }
    func setupConstraints() {
        marvelImageView.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        backGroundImageView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        chooseHeroLabel.snp.makeConstraints { (make) in
            make.top.equalTo(marvelImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(chooseHeroLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.80).offset(-70)
        }
        spinner.snp.makeConstraints {(make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

extension CellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19 // apiResult.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CustomCell else {
            return .init()
        }
        if !apiResult.isEmpty {
            var heroStr = "\(apiResult[indexPath.row].thumbnail?.path ?? "")/portrait_uncanny.\(apiResult[indexPath.row].thumbnail?.ext ?? "")"
            heroStr.insert(contentsOf: "s", at: heroStr.index(heroStr.startIndex, offsetBy: 4))
            let heroLabel = apiResult[indexPath.row].name ?? models.first?.heroes[indexPath.row].name ?? ""
            let heroImageData = models.first?.heroes[indexPath.row].pictureHero
            cell.setupCellView(image: heroStr, label: heroLabel, heroData: heroImageData)
        } else if !models.isEmpty {
            let heroStr = ""
            let heroLabel = models.first?.heroes[indexPath.row].name ?? ""
            let heroImageData = models.first?.heroes[indexPath.row].pictureHero
            cell.setupCellView(image: heroStr, label: heroLabel, heroData: heroImageData)
        }
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView is UICollectionView else { return }
        let centerPoint = CGPoint(x: scrollView.frame.size.width / 2 + scrollView.contentOffset.x,
                                  y: scrollView.frame.size.height / 2 + scrollView.contentOffset.y)
        if let indexPath = collectionView.indexPathForItem(at: centerPoint) {
            backGroundImageView.setTriangleColor(backgroundColors[indexPath.row])
        }
    }
}
