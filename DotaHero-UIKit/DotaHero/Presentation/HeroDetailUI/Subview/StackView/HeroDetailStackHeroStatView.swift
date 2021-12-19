//
//  HeroDetailStackHeroStatView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import UIKit

final class HeroDetailStackHeroStatView: UIStackView {
    
    lazy var bottomHeroStatRowView: HeroDetailStackHeroStatRowView = HeroDetailStackHeroStatRowView()
    lazy var centerHeroStatRowView: HeroDetailStackHeroStatRowView = HeroDetailStackHeroStatRowView()
    lazy var topHeroStatRowView: HeroDetailStackHeroStatRowView = HeroDetailStackHeroStatRowView()
    
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
        addArrangedSubview(topHeroStatRowView)
        addArrangedSubview(centerHeroStatRowView)
        addArrangedSubview(bottomHeroStatRowView)
    }
    
    private func makeConstraintSubviews() {
    }
    
    private func subviewDidLayout() {
    }
    
    private func viewDidInit() {
        axis = .vertical
        alignment = .fill
        distribution = .fillEqually
        spacing = 4
    }
}
