//
//  BSDStackSimilarHeroView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import UIKit

class BSDStackSimilarHeroView: UIStackView {
    
    lazy var centerHeroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var leftHeroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var rightHeroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var promptSimilarHeroLabel: UILabel = {
        let label = UILabel()
        label.text = "Similar Hero"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
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
        self.addArrangedSubview(self.promptSimilarHeroLabel)
        self.addArrangedSubview(self.leftHeroImageView)
        self.addArrangedSubview(self.centerHeroImageView)
        self.addArrangedSubview(self.rightHeroImageView)
    }
    
    private func subviewConstraintDidMake() {
    }
    
    private func subviewDidLayout() {
    }
    
    private func viewDidInit() {
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 10
    }
    
}
