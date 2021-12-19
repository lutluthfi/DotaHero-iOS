//
//  HeroListItemCollectionCell.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import DTDomainModule
import UIKit

final class HeroListItemCollectionCell: UICollectionViewCell {
    static let identifier = String(describing: HeroListItemCollectionCell.self)
    
    lazy var heroImageView: UIImageView = makeHeroImageView()
    lazy var heroNameLabel: UILabel = makeHeroNameLabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraintSubviews()
        viewDidInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviewDidLayout()
    }
    
    func makeHeroImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    func makeHeroNameLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }
}

extension HeroListItemCollectionCell {
    func addSubviews() {
        contentView.addSubview(heroImageView)
        contentView.addSubview(heroNameLabel)
    }
    
    func makeConstraintSubviews() {
    }
    
    func subviewDidLayout() {
        heroImageView.snp.remakeConstraints { (make) in
            make.height.equalTo(contentView.bounds.height * 0.7)
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(heroNameLabel.snp.top)
        }
        heroNameLabel.snp.remakeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func viewDidInit() {
    }
}

extension HeroListItemCollectionCell {
    func fill(with hero: HeroDomain) {
        heroNameLabel.text = hero.heroName
        heroImageView.kf.indicatorType = .activity
        heroImageView.kf.setImage(with: URL(string: hero.image)!, options: [.cacheOriginalImage])
    }
}
