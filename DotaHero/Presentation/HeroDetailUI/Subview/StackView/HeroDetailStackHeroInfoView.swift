//
//  HeroDetailStackHeroInfoView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import UIKit

final class HeroDetailStackHeroInfoView: UIStackView {
    
    lazy var heroImageView: UIImageView = makeHeroImageView()
    lazy var heroRoleLabel: UILabel = makeHeroRoleLabel()
    lazy var heroNameStackView: StackImageLabelView = StackImageLabelView()
    
    required init(coder: NSCoder) {
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
    
    private func addSubviews() {
        addArrangedSubview(heroImageView)
        addArrangedSubview(heroNameStackView)
        addArrangedSubview(heroRoleLabel)
    }
    
    private func makeConstraintSubviews() {
    }
    
    private func subviewDidLayout() {
    }
    
    private func viewDidInit() {
        axis = .vertical
        alignment = .fill
        distribution = .fillProportionally
        spacing = 4
    }
    
    func makeHeroImageView() -> UIImageView {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }
    
    func makeHeroRoleLabel() -> UILabel {
        let label = UILabel()
        label.text = "[Hero Role]"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
}
