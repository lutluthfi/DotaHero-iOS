//
//  BSDStackHeroStatRowView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import UIKit

class BSDStackHeroStatRowView: UIStackView {
    
    lazy var leftStatStackView: StackImageLabelView = {
        let view = StackImageLabelView()
        return view
    }()
    lazy var rightStatStackView: StackImageLabelView = {
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
        self.addArrangedSubview(self.leftStatStackView)
        self.addArrangedSubview(self.rightStatStackView)
    }
    
    private func subviewConstraintDidMake() {
    }
    
    private func subviewDidLayout() {
    }
    
    private func viewDidInit() {
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 4
    }
    
}
