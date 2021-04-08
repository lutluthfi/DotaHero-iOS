//
//  BSDStackHeroStatView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import UIKit

class BSDStackHeroStatView: UIStackView {
    
    lazy var bottomHeroStatRowView: BSDStackHeroStatRowView = {
        let view = BSDStackHeroStatRowView()
        return view
    }()
    lazy var centerHeroStatRowView: BSDStackHeroStatRowView = {
        let view = BSDStackHeroStatRowView()
        return view
    }()
    lazy var topHeroStatRowView: BSDStackHeroStatRowView = {
        let view = BSDStackHeroStatRowView()
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
        self.addArrangedSubview(self.topHeroStatRowView)
        self.addArrangedSubview(self.centerHeroStatRowView)
        self.addArrangedSubview(self.bottomHeroStatRowView)
    }
    
    private func subviewConstraintDidMake() {
    }
    
    private func subviewDidLayout() {
    }
    
    private func viewDidInit() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 4
    }
    
}
