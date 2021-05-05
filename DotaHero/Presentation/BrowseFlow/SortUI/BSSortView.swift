//
//  BSSortView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/05/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

// MARK: BSSortViewFunction
protocol BSSortViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
}

// MARK: BSSortViewSubview
protocol BSSortViewSubview {
    var applyBarButtonItem: UIBarButtonItem { get }
    var tableView: UITableView { get }
}

// MARK: BSSortViewVariable
protocol BSSortViewVariable {
    var factors: [String] { get }
}

// MARK: BSSortView
protocol BSSortView: BSSortViewFunction, BSSortViewSubview, BSSortViewVariable { }

// MARK: DefaultBSSortView
final class DefaultBSSortView: UIView, BSSortView {

    // MARK: BSSortViewSubview
    lazy var applyBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: nil)
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.fixedCoordinateSpace.bounds, style: .plain)
        return tableView
    }()

    // MARK: BSSortViewVariable
    lazy var factors: [String] = [HeroStatDomain.sortByBaseAttack,
                                  HeroStatDomain.sortByBaseHealth,
                                  HeroStatDomain.sortByBaseMana,
                                  HeroStatDomain.sortByBaseSpeed]
    
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
extension DefaultBSSortView {
    
    func subviewWillAdd() {
    }
    
    func subviewConstraintWillMake() {
    }
    
    func subviewDidLayout() {
    }
    
    func viewDidInit() {
    }
    
}

// MARK: BSSortViewFunction
extension DefaultBSSortView {
    
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?) {
        navigationItem.title = "Sort Heroes"
        navigationItem.rightBarButtonItem = self.applyBarButtonItem
    }
    
    func viewWillDisappear() {
        
    }
    
}
