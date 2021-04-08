//
//  BSLHeroCollectionCell.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import UIKit

class BSLHeroCollectionCell: UICollectionViewCell {

    static let identifier = String(describing: BSLHeroCollectionCell.self)
    
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
        self.subviewDidAdd()
        self.subviewConstraintDidMake()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subviewDidLayout()
    }
    
    private func subviewDidAdd() {
        self.contentView.addSubview(self.heroImageView)
        self.contentView.addSubview(self.heroNameLabel)
    }
    
    private func subviewConstraintDidMake() {
        self.heroImageView.snp.makeConstraints { (make) in
            make.height.equalTo(self.contentView.bounds.height * 0.7)
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(self.heroNameLabel.snp.top)
        }
        self.heroNameLabel.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func subviewDidLayout() {
    }
    
}

extension BSLHeroCollectionCell {
    
    func fill(with heroStat: HeroStatDomain) {
        self.heroNameLabel.text = heroStat.heroName
        self.heroImageView.kf.indicatorType = .activity
        self.heroImageView.kf.setImage(with: URL(string: heroStat.image)!, options: [.cacheOriginalImage])
    }
    
}
