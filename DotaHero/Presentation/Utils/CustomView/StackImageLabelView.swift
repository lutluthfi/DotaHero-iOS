//
//  StackImageLabelView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import UIKit

class StackImageLabelView: UIStackView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.autoresizesSubviews = true
        return imageView
    }()
    lazy var textLabel: UILabel = {
       let label = UILabel()
        label.text = "[Text]"
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
        self.addArrangedSubview(self.imageView)
        self.addArrangedSubview(self.textLabel)
    }
    
    private func subviewConstraintDidMake() {
        self.imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
    }
    
    private func subviewDidLayout() {
    }
    
    private func viewDidInit() {
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fill
    }
    
}
