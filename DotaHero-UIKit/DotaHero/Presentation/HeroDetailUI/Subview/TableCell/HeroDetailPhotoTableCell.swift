//
//  HeroDetailPhotoTableCell.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 04/05/21.
//

import Kingfisher
import SnapKit
import UIKit

final class HeroDetailPhotoTableCell: UITableViewCell {
    
    static let identifier = String(describing: HeroDetailPhotoTableCell.self)
    
    lazy var heroImageView: UIImageView = makeHeroImageView()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(reuseIdentifier: String? = HeroDetailPhotoTableCell.identifier) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeConstraintSubviews()
        viewDidInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviewDidLayout()
    }

    func makeHeroImageView() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }
}

extension HeroDetailPhotoTableCell {
    func subviewDidLayout() {
    }
    
    func addSubviews() {
        contentView.addSubview(heroImageView)
    }
    
    func makeConstraintSubviews() {
        heroImageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    func viewDidInit() {
    }
}

extension HeroDetailPhotoTableCell {
    func fill(with imageURL: URL) {
        heroImageView.kf.indicatorType = .activity
        heroImageView.kf.setImage(with: imageURL, options: [.cacheOriginalImage])
    }
}
