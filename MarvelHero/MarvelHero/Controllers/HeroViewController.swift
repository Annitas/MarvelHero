//
//  HeroInformationController.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 27.10.2022.
//

import UIKit
import SnapKit

final class HeroViewController: UIViewController {
    private lazy var heroImageView: UIImageView = {
        var heroView = UIImageView()
        heroView.clipsToBounds = true
        heroView.contentMode = .scaleAspectFill
        return heroView
    }()
    private let heroLabelName: UILabel = {
        var heroLabel = UILabel()
        heroLabel.textColor = .white
        heroLabel.font = .boldSystemFont(ofSize: 28)
        return heroLabel
    }()
    private let heroInfo: UILabel = {
        var heroInfoView = UILabel()
        heroInfoView.textColor = .white
        heroInfoView.font = .boldSystemFont(ofSize: 22)
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
        view.addSubview(heroImageView)
        view.addSubview(heroLabelName)
        view.addSubview(heroInfo)
        setupConstraints()
    }
    func setupConstraints() {
        heroImageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        heroLabelName.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-60)
            make.left.equalTo(20)
        }
        heroInfo.snp.makeConstraints { (make) in
            make.top.equalTo(heroLabelName.snp.bottom).offset(2)
            make.left.equalTo(20)
        }
    }
}
