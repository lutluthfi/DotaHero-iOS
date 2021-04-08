//
//  BSListView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: BSListViewFunction
protocol BSListViewFunction {
    func viewDidLoad(navigationBar: UINavigationBar?,
                     navigationItem: UINavigationItem,
                     tabBarController: UITabBarController?)
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func setNavigationItemTitle(_ navigationItem: UINavigationItem, title: String)
}

// MARK: BSListViewSubview
protocol BSListViewSubview {
    var collectionView: UICollectionView { get }
    var tableView: UITableView { get }
}

// MARK: BSListViewVariable
protocol BSListViewVariable {
}

// MARK: BSListView
protocol BSListView: BSListViewFunction, BSListViewSubview, BSListViewVariable { }

// MARK: DefaultBSListView
final class DefaultBSListView: UIView, BSListView {

    // MARK: BSListViewSubview
    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(BSLHeroCollectionCell.self,
                                forCellWithReuseIdentifier: BSLHeroCollectionCell.identifier)
        return collectionView
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BSLHeroTableCell.self, forCellReuseIdentifier: BSLHeroTableCell.identifier)
        tableView.rowHeight = BSLHeroTableCell.height
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        return tableView
    }()
    
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
extension DefaultBSListView {
    
    func subviewWillAdd() {
        self.addSubview(self.tableView)
        self.addSubview(self.collectionView)
    }
    
    func subviewConstraintWillMake() {
    }
    
    func subviewDidLayout() {
        self.tableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.bounds.width / 5)
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        self.collectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.tableView.snp.trailing)
            make.top.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func viewDidInit() {
    }
    
}

// MARK: BSListViewFunction
extension DefaultBSListView {
    
    func viewDidLoad(navigationBar: UINavigationBar?,
                     navigationItem: UINavigationItem,
                     tabBarController: UITabBarController?) {
        navigationItem.title = "Dota 2"
    }
    
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?) {
    }
    
    func viewWillDisappear() {
    }
    
    func setNavigationItemTitle(_ navigationItem: UINavigationItem, title: String) {
        navigationItem.title = title
    }
    
}
