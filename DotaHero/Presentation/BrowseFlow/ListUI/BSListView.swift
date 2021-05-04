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
    var heroCollectionView: UICollectionView { get }
    var roleCollectionView: UICollectionView { get }
}

// MARK: BSListViewVariable
protocol BSListViewVariable {
}

// MARK: BSListView
protocol BSListView: BSListViewFunction, BSListViewSubview, BSListViewVariable { }

// MARK: DefaultBSListView
final class DefaultBSListView: UIView, BSListView {

    // MARK: BSListViewSubview
    lazy var heroCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(BSLSHeroCollectionCell.self,
                                forCellWithReuseIdentifier: BSLSHeroCollectionCell.identifier)
        return collectionView
    }()
    lazy var roleCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(BSLSRoleCollectionCell.self,
                                forCellWithReuseIdentifier: BSLSRoleCollectionCell.identifier)
        return collectionView
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
        self.addSubview(self.heroCollectionView)
        self.addSubview(self.roleCollectionView)
    }
    
    func subviewConstraintWillMake() {
    }
    
    func subviewDidLayout() {
        let collectionViewLayout = self.roleCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            collectionViewLayout.scrollDirection = .vertical
            self.roleCollectionView.snp.remakeConstraints { (make) in
                make.width.equalTo(self.bounds.width / 5)
                make.leading.equalTo(self.safeAreaLayoutGuide)
                make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            }
            self.heroCollectionView.snp.remakeConstraints { (make) in
                make.leading.equalTo(self.roleCollectionView.snp.trailing)
                make.top.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            }
        default:
            collectionViewLayout.scrollDirection = .horizontal
            self.roleCollectionView.snp.remakeConstraints { (make) in
                make.height.equalTo(44)
                make.leading.equalTo(self.safeAreaLayoutGuide)
                make.top.equalTo(self.safeAreaLayoutGuide)
                make.trailing.equalTo(self.safeAreaLayoutGuide)
            }
            self.heroCollectionView.snp.remakeConstraints { (make) in
                make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
                make.top.equalTo(self.roleCollectionView.snp.bottom)
            }
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
