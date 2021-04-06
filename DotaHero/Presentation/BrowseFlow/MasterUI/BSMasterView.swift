//
//  BSMasterView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/04/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: BSMasterViewDelegate
protocol BSMasterViewDelegate: AnyObject {
    
}

// MARK: BSMasterViewFunction
protocol BSMasterViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
}

// MARK: BSMasterViewSubview
protocol BSMasterViewSubview {
}

// MARK: BSMasterViewVariable
protocol BSMasterViewVariable {
    var delegate: BSMasterViewDelegate? { get }
}

// MARK: BSMasterView
protocol BSMasterView: BSMasterViewFunction, BSMasterViewSubview, BSMasterViewVariable { }

// MARK: DefaultBSMasterView
final class DefaultBSMasterView: UIView, BSMasterView {

    // MARK: BSMasterViewSubview

    // MARK: BSMasterViewVariable
    weak var delegate: BSMasterViewDelegate?
    
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
extension DefaultBSMasterView {
    
    func subviewWillAdd() {
    }
    
    func subviewConstraintWillMake() {
    }
    
    func subviewDidLayout() {
    }
    
    func viewDidInit() {
    }
    
}

// MARK: BSMasterViewFunction
extension DefaultBSMasterView {
    
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?) {
    }
    
    func viewWillDisappear() {
        
    }
    
}
