//
//  HeroDetailView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import DTDomainModule
import RxRelay
import RxSwift
import UIKit

protocol HeroDetailViewFunction {
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    )
    func viewWillDisappear()
    func insertNewSection(_ section: SectionDomain<TableRowDomain>)
}

protocol HeroDetailViewSubview {
    var tableView: UITableView { get }
}

protocol HeroDetailViewVariable {
    var tableSections: [SectionDomain<TableRowDomain>] { get }
}

protocol HeroDetailView: HeroDetailViewFunction, HeroDetailViewSubview, HeroDetailViewVariable { }

final class HeroDetailViewImpl: UIView, HeroDetailView {
    
    lazy var tableView: UITableView = {
        let frame: CGRect = UIScreen.main.fixedCoordinateSpace.bounds
        let tableView = UITableView(frame: frame, style: .grouped)
        tableView.rowHeight = CGFloat(44)
        return tableView
    }()
    
    lazy var tableSections: [SectionDomain<TableRowDomain>] = [
        SectionDomain(header: "", footer: "", items: [.heroImage]),
        SectionDomain(header: "", footer: "", items: [.heroName]),
        SectionDomain(header: "", footer: "", items: [.attackType]),
        SectionDomain(
            header: "",
            footer: "",
            items: [.baseHealth, .baseMana, .baseArmor, .baseAttack]
        ),
        SectionDomain(header: "", footer: "", items: [.moveSpeed])
    ]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: UIScreen.main.fixedCoordinateSpace.bounds)
        addSubviews()
        makeConstraintSubviews()
        viewDidInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviewDidLayout()
    }
    
}

extension HeroDetailViewImpl {
    func addSubviews() {
    }
    
    func makeConstraintSubviews() {
    }
    
    func subviewDidLayout() {
    }
    
    func viewDidInit() {
        backgroundColor = .white
    }
}

extension HeroDetailViewImpl {
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {
    }
    
    func viewWillDisappear() {
    }
    
    func insertNewSection(_ section: SectionDomain<TableRowDomain>) {
        tableSections.append(section)
    }
}
