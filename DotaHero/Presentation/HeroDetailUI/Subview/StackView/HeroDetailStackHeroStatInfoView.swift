//
//  HeroDetailStackHeroStatInfoView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import UIKit

final class HeroDetailStackHeroStatInfoView: UIStackView {
    lazy var heroInfoStackView: HeroDetailStackHeroInfoView = HeroDetailStackHeroInfoView()
    lazy var heroStatStackView: HeroDetailStackHeroStatView = HeroDetailStackHeroStatView()
    
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
        addArrangedSubview(heroInfoStackView)
        addArrangedSubview(heroStatStackView)
    }
    
    private func makeConstraintSubviews() {
    }
    
    private func subviewDidLayout() {
    }
    
    private func viewDidInit() {
        axis = .horizontal
        alignment = .fill
        distribution = .fillEqually
        spacing = 10
    }
}
