//
//  BSLHeroTableCell.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import UIKit

class BSLHeroTableCell: UITableViewCell {
    
    static let identifier = String(describing: BSLHeroTableCell.self)
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
    
    init(style: UITableViewCell.CellStyle) {
        super.init(style: style, reuseIdentifier: BSLHeroTableCell.identifier)
        self.subviewDidAdd()
        self.subviewConstraintDidMake()
        self.viewDidInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subviewDidLayout()
    }
    
    private func subviewDidAdd() {
        self.contentView.addSubview(self.containerContentView)
        self.containerContentView.addSubview(self.roleLabel)
    }
    
    private func subviewConstraintDidMake() {
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
        self.selectionStyle = .none
    }

}
