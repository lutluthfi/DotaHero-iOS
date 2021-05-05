//
//  BSDetailView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import RxRelay
import RxSwift
import UIKit

// MARK: BSDetailViewFunction
protocol BSDetailViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func insertNewSection(_ section: SectionDomain<TableRowDomain>)
}

// MARK: BSDetailViewSubview
protocol BSDetailViewSubview {
    var tableView: UITableView { get }
}

// MARK: BSDetailViewVariable
protocol BSDetailViewVariable {
    var tableSections: [SectionDomain<TableRowDomain>] { get }
}

// MARK: BSDetailView
protocol BSDetailView: BSDetailViewFunction, BSDetailViewSubview, BSDetailViewVariable { }

// MARK: DefaultBSDetailView
final class DefaultBSDetailView: UIView, BSDetailView {
    
    // MARK: BSDetailViewSubview
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.fixedCoordinateSpace.bounds, style: .grouped)
        tableView.rowHeight = CGFloat(44)
        return tableView
    }()
    
    // MARK: BSDetailViewVariable
    lazy var tableSections: [SectionDomain<TableRowDomain>] = [SectionDomain(header: "", footer: "", items: [.heroImage]),
                                                               SectionDomain(header: "", footer: "", items: [.heroName]),
                                                               SectionDomain(header: "", footer: "", items: [.attackType]),
                                                               SectionDomain(header: "", footer: "", items: [.baseHealth,
                                                                                                             .baseMana,
                                                                                                             .baseArmor,
                                                                                                             .baseAttack]),
                                                               SectionDomain(header: "", footer: "", items: [.moveSpeed])]
    
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
    
    func insertNewSection(_ section: SectionDomain<TableRowDomain>) {
        self.tableSections.append(section)
    }
    
}
