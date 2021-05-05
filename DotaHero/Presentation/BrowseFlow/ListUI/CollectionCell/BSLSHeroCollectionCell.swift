//
//  BSLSHeroCollectionCell.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import UIKit

class BSLSHeroCollectionCell: UICollectionViewCell {

    static let identifier = String(describing: BSLSHeroCollectionCell.self)
    
    lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var heroNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.subviewWillAdd()
        self.subviewConstraintWillMake()
        self.viewDidInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subviewDidLayout()
    }
    
}

extension BSLSHeroCollectionCell {
    
    func subviewWillAdd() {
        self.contentView.addSubview(self.heroImageView)
        self.contentView.addSubview(self.heroNameLabel)
    }
    
    func subviewConstraintWillMake() {
    }
    
    func subviewDidLayout() {
        self.heroImageView.snp.remakeConstraints { (make) in
            make.height.equalTo(self.contentView.bounds.height * 0.7)
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(self.heroNameLabel.snp.top)
        }
        self.heroNameLabel.snp.remakeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func viewDidInit() {
    }
    
}

extension BSLSHeroCollectionCell {
    
    func fill(with heroStat: HeroStatDomain) {
        self.heroNameLabel.text = heroStat.heroName
        self.heroImageView.kf.indicatorType = .activity
        self.heroImageView.kf.setImage(with: URL(string: heroStat.image)!, options: [.cacheOriginalImage])
    }
    
}
