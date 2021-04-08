//
//  BSDetailController.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import RxCocoa
import RxSwift
import UIKit

// MARK: BSDetailController
final class BSDetailController: UIViewController {
    
    // MARK: DI Variable
    lazy var detailView: BSDetailView = DefaultBSDetailView()
    lazy var _view = (self.detailView as! UIView)
    var viewModel: BSDetailViewModel!
    
    // MARK: Common Variable
    let disposeBag = DisposeBag()
    
    // MARK: Create Function
    class func create(with viewModel: BSDetailViewModel) -> BSDetailController {
        let controller = BSDetailController()
        controller.viewModel = viewModel
        return controller
    }
    
    // MARK: UIViewController Function
    override func loadView() {
        self.view = self._view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(view: self.detailView, viewModel: self.viewModel)
        self.viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.detailView.viewWillAppear(navigationBar: self.navigationController?.navigationBar,
                                       navigationItem: self.navigationItem,
                                       tabBarController: self.tabBarController)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.detailView.viewWillDisappear()
    }
    
    // MARK: Bind ViewModel Function
    private func bind(view: BSDetailView, viewModel: BSDetailViewModel) {
        self.bindShowedHeroStatsAndSimilarHeroesToView(observable: viewModel.showedHeroStatAndSimilarHeroes, view: view)
    }
    
}

// MARK: Bind Function
extension BSDetailController {
    
    func bindShowedHeroStatsAndSimilarHeroesToView(observable: Observable<(HeroStatDomain, [HeroStatDomain])>,
                                                   view: BSDetailView) {
        observable.bind { (observable) in
            let heroStat = observable.0
            let similarHeroes = observable.1
            view.fill(with: heroStat, similarHeroes: similarHeroes)
        }.disposed(by: self.disposeBag)
    }
    
}
