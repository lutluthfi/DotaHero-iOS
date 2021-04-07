//
//  BSDetailView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: BSDetailViewDelegate
protocol BSDetailViewDelegate: AnyObject {
    
}

// MARK: BSDetailViewFunction
protocol BSDetailViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
}

// MARK: BSDetailViewSubview
protocol BSDetailViewSubview {
}

// MARK: BSDetailViewVariable
protocol BSDetailViewVariable {
    var delegate: BSDetailViewDelegate? { get }
}

// MARK: BSDetailView
protocol BSDetailView: BSDetailViewFunction, BSDetailViewSubview, BSDetailViewVariable { }

// MARK: DefaultBSDetailView
final class DefaultBSDetailView: UIView, BSDetailView {

    // MARK: BSDetailViewSubview

    // MARK: BSDetailViewVariable
    weak var delegate: BSDetailViewDelegate?
    
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
    
}
