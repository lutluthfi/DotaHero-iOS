//
//  BSDTPhotoTableCell.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 04/05/21.
//

import UIKit

class BSDTPhotoTableCell: UITableViewCell {
    
    static let identifier = String(describing: BSDTPhotoTableCell.self)
    
    lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(reuseIdentifier: String? = BSDTPhotoTableCell.identifier) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.subviewWillAdd()
        self.subviewConstraintWillMake()
        self.viewDidInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subviewDidLayout()
    }

}

extension BSDTPhotoTableCell {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.contentView.addSubview(self.heroImageView)
    }
    
    func subviewConstraintWillMake() {
        self.heroImageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    func viewDidInit() {
    }
    
}

extension BSDTPhotoTableCell {
    
    func fill(with imageURL: URL) {
        self.heroImageView.kf.indicatorType = .activity
        self.heroImageView.kf.setImage(with: imageURL, options: [.cacheOriginalImage])
    }
    
}
