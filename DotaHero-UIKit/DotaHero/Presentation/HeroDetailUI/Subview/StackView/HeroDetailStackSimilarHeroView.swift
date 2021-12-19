//
//  HeroDetailStackSimilarHeroView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import UIKit

final class HeroDetailStackSimilarHeroView: UIStackView {
    
    lazy var centerHeroImageView: UIImageView = makeCenterHeroImageView()
    lazy var leftHeroImageView: UIImageView = makeLeftHeroImageView()
    lazy var rightHeroImageView: UIImageView = makeRightHeroImageView()
    lazy var promptSimilarHeroLabel: UILabel = makePromptSimilarHeroImageView()
    
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
        addArrangedSubview(promptSimilarHeroLabel)
        addArrangedSubview(leftHeroImageView)
        addArrangedSubview(centerHeroImageView)
        addArrangedSubview(rightHeroImageView)
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
    
    func makeCenterHeroImageView() -> UIImageView {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }
    
    func makeLeftHeroImageView() -> UIImageView {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }
    
    func makeRightHeroImageView() -> UIImageView {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }
    
    func makePromptSimilarHeroImageView() -> UILabel {
        let view = UILabel()
        view.text = "Similar Hero"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 17, weight: .bold)
        return view
    }
}
