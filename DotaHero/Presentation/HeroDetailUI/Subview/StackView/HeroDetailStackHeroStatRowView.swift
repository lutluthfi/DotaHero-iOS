//
//  HeroDetailStackHeroStatRowView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import UIKit

final class HeroDetailStackHeroStatRowView: UIStackView {
    lazy var leftStatStackView: StackImageLabelView = StackImageLabelView()
    lazy var rightStatStackView: StackImageLabelView = StackImageLabelView()
    
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
        addArrangedSubview(leftStatStackView)
        addArrangedSubview(rightStatStackView)
    }
    
    private func makeConstraintSubviews() {
    }
    
    private func subviewDidLayout() {
    }
    
    private func viewDidInit() {
        axis = .horizontal
        alignment = .fill
        distribution = .fillEqually
        spacing = 4
    }
}
