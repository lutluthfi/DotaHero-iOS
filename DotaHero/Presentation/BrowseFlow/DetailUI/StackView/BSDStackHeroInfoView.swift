//
//  BSDStackHeroInfoView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import UIKit

class BSDStackHeroInfoView: UIStackView {
    
    lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var heroRoleLabel: UILabel = {
        let label = UILabel()
        label.text = "[Hero Role]"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    lazy var heroNameStackView: StackImageLabelView = {
        let view = StackImageLabelView()
        return view
    }()
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.subviewDidAdd()
        self.subviewConstraintDidMake()
        self.viewDidInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subviewDidLayout()
    }
    
    private func subviewDidAdd() {
        self.addArrangedSubview(self.heroImageView)
        self.addArrangedSubview(self.heroNameStackView)
        self.addArrangedSubview(self.heroRoleLabel)
    }
    
    private func subviewConstraintDidMake() {
    }
    
    private func subviewDidLayout() {
    }
    
    private func viewDidInit() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillProportionally
        self.spacing = 4
    }
    
}
