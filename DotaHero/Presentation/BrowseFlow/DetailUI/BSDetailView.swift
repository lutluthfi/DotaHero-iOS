//
//  BSDetailView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: BSDetailViewFunction
protocol BSDetailViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func fill(with heroStat: HeroStatDomain, similarHeroes: [HeroStatDomain])
}

// MARK: BSDetailViewSubview
protocol BSDetailViewSubview {
    var tableView: UITableView { get }
}

// MARK: BSDetailViewVariable
protocol BSDetailViewVariable {
}

// MARK: BSDetailView
protocol BSDetailView: BSDetailViewFunction, BSDetailViewSubview, BSDetailViewVariable { }

// MARK: DefaultBSDetailView
final class DefaultBSDetailView: UIView, BSDetailView {
    
    // MARK: BSDetailViewSubview
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.frame, style: .grouped)
        
        return tableView
    }()
    
    // MARK: BSDetailViewVariable
    
    // MARK: Init Function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: UIScreen.main.fixedCoordinateSpace.bounds)
        self.subviewWillAdd()
        self.subviewConstraintWillMake()
        self.viewDidInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subviewDidLayout()
    }
    
}

// MARK: Internal Function
extension DefaultBSDetailView {
    
    func subviewWillAdd() {
        
    }
    
    func subviewConstraintWillMake() {
    }
    
    func subviewDidLayout() {
    }
    
    func viewDidInit() {
        self.backgroundColor = .white
    }
    
}

// MARK: BSDetailViewFunction
extension DefaultBSDetailView {
    
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?) {
    }
    
    func viewWillDisappear() {
    }
    
    func fill(with heroStat: HeroStatDomain, similarHeroes: [HeroStatDomain]) {
//        self.heroStatInfoView.heroInfoStackView.heroImageView.kf.indicatorType = .activity
//        self.heroStatInfoView.heroInfoStackView.heroImageView.kf.setImage(with: URL(string: heroStat.image)!,
//                                                                          options: [.cacheOriginalImage])
//
//        self.heroStatInfoView.heroInfoStackView.heroNameStackView.imageView.image = self.makeImage(with: "🏹")
//        self.heroStatInfoView.heroInfoStackView.heroNameStackView.textLabel.text = heroStat.heroName
//
//        let heroRole = heroStat.roles.joined(separator: ", ")
//        self.heroStatInfoView.heroInfoStackView.heroRoleLabel.text = "Role:\n\(heroRole)"
//
//        self.heroStatInfoView.heroStatStackView.topHeroStatRowView.leftStatStackView.imageView.image = self.makeImage(with: "⚔️")
//        self.heroStatInfoView.heroStatStackView.topHeroStatRowView.leftStatStackView.textLabel.text = "\(heroStat.baseAttackMin) - \(heroStat.baseAttackMax)"
//
//        self.heroStatInfoView.heroStatStackView.topHeroStatRowView.rightStatStackView.imageView.image = self.makeImage(with: "➕")
//        self.heroStatInfoView.heroStatStackView.topHeroStatRowView.rightStatStackView.textLabel.text = "\(heroStat.baseHealth)"
//
//        self.heroStatInfoView.heroStatStackView.centerHeroStatRowView.leftStatStackView.imageView.image = self.makeImage(with: "🛡")
//        self.heroStatInfoView.heroStatStackView.centerHeroStatRowView.leftStatStackView.textLabel.text = "\(heroStat.baseArmor)"
//
//        self.heroStatInfoView.heroStatStackView.centerHeroStatRowView.rightStatStackView.imageView.image = self.makeImage(with: "🍶")
//        self.heroStatInfoView.heroStatStackView.centerHeroStatRowView.rightStatStackView.textLabel.text = "\(heroStat.baseMana)"
//
//        self.heroStatInfoView.heroStatStackView.bottomHeroStatRowView.leftStatStackView.imageView.image = self.makeImage(with: "🥾")
//        self.heroStatInfoView.heroStatStackView.bottomHeroStatRowView.leftStatStackView.textLabel.text = "\(heroStat.moveSpeed)"
//
//        self.heroStatInfoView.heroStatStackView.bottomHeroStatRowView.rightStatStackView.imageView.image = self.makeImage(with: "⛓")
//        self.heroStatInfoView.heroStatStackView.bottomHeroStatRowView.rightStatStackView.textLabel.text = "\(heroStat.primaryAttribute)"
//
//        guard similarHeroes.count == 3 else { return }
//        self.similarHeroView.leftHeroImageView.kf.indicatorType = .activity
//        self.similarHeroView.leftHeroImageView.kf.setImage(with: URL(string: similarHeroes[0].image)!,
//                                                           options: [.cacheOriginalImage])
//
//        self.similarHeroView.centerHeroImageView.kf.indicatorType = .activity
//        self.similarHeroView.centerHeroImageView.kf.setImage(with: URL(string: similarHeroes[1].image)!,
//                                                             options: [.cacheOriginalImage])
//
//        self.similarHeroView.rightHeroImageView.kf.indicatorType = .activity
//        self.similarHeroView.rightHeroImageView.kf.setImage(with: URL(string: similarHeroes[2].image)!,
//                                                            options: [.cacheOriginalImage])
    }
    
    private func makeImage(with string: String) -> UIImage? {
        return string.image(withAttributes: [.font: UIFont.systemFont(ofSize: 22)], size: CGSize(width: 30, height: 30))
    }
    
}
