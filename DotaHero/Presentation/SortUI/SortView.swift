//
//  SortView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/05/21.
//  Copyright (c) 2021 All rights reserved.
//

import DTDomainModule
import UIKit

protocol SortViewFunction {
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    )
    func viewWillDisappear()
}

protocol SortViewSubview {
    var applyBarButtonItem: UIBarButtonItem { get }
    var tableView: UITableView { get }
}

protocol SortViewVariable {
    var factors: [String] { get }
}

protocol SortView: SortViewFunction, SortViewSubview, SortViewVariable { }

final class SortViewImpl: UIView, SortView {

    lazy var applyBarButtonItem = UIBarButtonItem(
        title: "Apply",
        style: .done,
        target: self,
        action: nil
    )
    lazy var tableView: UITableView = {
        let frame: CGRect = UIScreen.main.fixedCoordinateSpace.bounds
        let tableView = UITableView(frame: frame, style: .plain)
        return tableView
    }()

    lazy var factors: [String] = [
        HeroDomain.sortByBaseAttack,
        HeroDomain.sortByBaseHealth,
        HeroDomain.sortByBaseMana,
        HeroDomain.sortByBaseSpeed
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

extension SortViewImpl {
    func addSubviews() {
    }
    
    func makeConstraintSubviews() {
    }
    
    func subviewDidLayout() {
    }
    
    func viewDidInit() {
    }
}

extension SortViewImpl {
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {
        navigationItem.title = "Sort Heroes"
        navigationItem.rightBarButtonItem = applyBarButtonItem
    }
    
    func viewWillDisappear() {
        
    }
}
