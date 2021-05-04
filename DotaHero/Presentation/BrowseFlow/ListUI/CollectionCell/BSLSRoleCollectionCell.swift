//
//  BSLSRoleCollectionCell.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 04/05/21.
//

import UIKit

class BSLSRoleCollectionCell: UICollectionViewCell {
    
    static let identifier = String(describing: BSLSRoleCollectionCell.self)
    static let height = CGFloat(44)
    
    lazy var containerContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.makeRound()
        return view
    }()
    lazy var roleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.containerContentView.backgroundColor = self.isSelected ? .white : .black
            self.roleLabel.textColor = self.isSelected ? .black : .white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.subviewWillAdd()
        self.subviewConstraintWillMake()
        self.viewDidInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subviewDidLayout()
    }
    
    private func subviewWillAdd() {
        self.contentView.addSubview(self.containerContentView)
        self.containerContentView.addSubview(self.roleLabel)
    }
    
    private func subviewConstraintWillMake() {
        self.containerContentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(2)
        }
        self.roleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(2)
        }
    }
    
    private func subviewDidLayout() {
    }
    
    private func viewDidInit() {
    }
    
}

extension BSLSRoleCollectionCell {
    
    func fill(with role: String) {
        self.roleLabel.text = role
    }
    
}
