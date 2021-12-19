//
//  HeroListView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

protocol HeroListViewFunction {
    func viewDidLoad(
        navigationController: UINavigationController?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?,
        toolbarItems: inout [UIBarButtonItem]?
    )
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    )
    func viewWillDisappear()
    func setNavigationItemTitle(_ navigationItem: UINavigationItem, title: String)
}

protocol HeroListViewSubview {
    var heroCollectionView: UICollectionView { get }
    var roleCollectionView: UICollectionView { get }
    var sortBarButtonItem: UIBarButtonItem { get }
}

protocol HeroListViewVariable {
}

protocol HeroListView: HeroListViewFunction, HeroListViewSubview, HeroListViewVariable { }

final class HeroListViewImpl: UIView, HeroListView {
    
    lazy var heroCollectionView: UICollectionView = makeHeroCollectionView()
    lazy var roleCollectionView: UICollectionView = makeRoleCollectionView()
    lazy var sortBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "line.horizontal.3.decrease.circle"),
        style: .done,
        target: self,
        action: nil
    )
    
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
    
    func makeHeroCollectionView() -> UICollectionView {
        let viewFlowLayout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: viewFlowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.register(
            HeroListItemCollectionCell.self,
            forCellWithReuseIdentifier: HeroListItemCollectionCell.identifier
        )
        return view
    }
    
    func makeRoleCollectionView() -> UICollectionView {
        let viewFlowLayout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: viewFlowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.register(
            HeroListRoleItemCollectionCell.self,
            forCellWithReuseIdentifier: HeroListRoleItemCollectionCell.identifier
        )
        return view
    }
}

extension HeroListViewImpl {
    func addSubviews() {
        addSubview(heroCollectionView)
        addSubview(roleCollectionView)
    }
    
    func makeConstraintSubviews() {
    }
    
    func subviewDidLayout() {
        let collectionViewLayout = roleCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            collectionViewLayout.scrollDirection = .vertical
            roleCollectionView.snp.remakeConstraints { (make) in
                make.width.equalTo(bounds.width / 5)
                make.leading.equalTo(safeAreaLayoutGuide)
                make.top.bottom.equalTo(safeAreaLayoutGuide)
            }
            heroCollectionView.snp.remakeConstraints { (make) in
                make.leading.equalTo(roleCollectionView.snp.trailing)
                make.top.trailing.bottom.equalTo(safeAreaLayoutGuide)
            }
        default:
            collectionViewLayout.scrollDirection = .horizontal
            roleCollectionView.snp.remakeConstraints { (make) in
                make.height.equalTo(44)
                make.leading.equalTo(safeAreaLayoutGuide)
                make.top.equalTo(safeAreaLayoutGuide)
                make.trailing.equalTo(safeAreaLayoutGuide)
            }
            heroCollectionView.snp.remakeConstraints { (make) in
                make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
                make.top.equalTo(roleCollectionView.snp.bottom)
            }
        }
    }
    
    func viewDidInit() {
    }
}

extension HeroListViewImpl {
    func viewDidLoad(
        navigationController: UINavigationController?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?,
        toolbarItems: inout [UIBarButtonItem]?
    ) {
        navigationItem.title = "Dota 2"
        navigationController?.isToolbarHidden = false
        navigationItem.rightBarButtonItem = sortBarButtonItem
    }
    
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {
    }
    
    func viewWillDisappear() {
    }
    
    func setNavigationItemTitle(_ navigationItem: UINavigationItem, title: String) {
        navigationItem.title = title
    }
}
