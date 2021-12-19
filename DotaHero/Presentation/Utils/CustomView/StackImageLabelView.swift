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
        addSubviews()
        makeConstraintSubviews()
        viewDidInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviewDidLayout()
    }
    
    private func addSubviews() {
        addArrangedSubview(imageView)
        addArrangedSubview(textLabel)
    }
    
    private func makeConstraintSubviews() {
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
    }
    
    private func subviewDidLayout() {
    }
    
    private func viewDidInit() {
        axis = .horizontal
        alignment = .fill
        distribution = .fill
    }
    
}
