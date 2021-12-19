//
//  HeroDetailController.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import DTDomainModule
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class HeroDetailController: UITableViewController {
    typealias TableDataSource = RxTableAnimatedDataSource<SectionDomain<TableRowDomain>>
    
    lazy var detailView: HeroDetailView = HeroDetailViewImpl()
    let disposeBag = DisposeBag()
    var viewModel: HeroDetailViewModel!
    
    let showedHeroes = BehaviorRelay<HeroDomain?>(value: nil)
    
    class func create(with viewModel: HeroDetailViewModel) -> HeroDetailController {
        let controller = HeroDetailController()
        controller.viewModel = viewModel
        return controller
    }
    
    override func loadView() {
        view = detailView.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableViewDelegate(tableView: detailView.tableView)
        bindRxEventShowedHeroes(viewModel.rxEventShowHeroes)
        bindShowedHeroStatToNavigationItemTitle(
            relay: showedHeroes,
            navigationItem: navigationItem
        )
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailView.viewWillAppear(
            navigationBar: navigationController?.navigationBar,
            navigationItem: navigationItem,
            tabBarController: tabBarController
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindHeroStatToTableView(
            observable: .just(detailView.tableSections),
                                     tableView: detailView.tableView
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        detailView.viewWillDisappear()
    }
    
}

extension HeroDetailController {
    func bindRxEventShowedHeroes(_ observable: Observable<HeroDomain>) {
        observable
            .do(onNext: { [unowned self] (hero) in
                var roles: [TableRowDomain] = []
                hero.roles.forEach { (_) in
                    roles.append(.role)
                }
                let section = SectionDomain(header: "Role", footer: "", items: roles)
                detailView.insertNewSection(section)
            })
            .bind(to: showedHeroes)
            .disposed(by: disposeBag)
    }
}

extension HeroDetailController {
    func bindShowedHeroStatToNavigationItemTitle(
        relay: BehaviorRelay<HeroDomain?>,
        navigationItem: UINavigationItem
    ) {
        relay
            .asDriver()
            .compactMap({ $0?.heroName })
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
}

extension HeroDetailController {
    func bindTableViewDelegate(tableView: UITableView) {
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension HeroDetailController {
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        let rowModel = detailView.tableSections[indexPath.section].items[indexPath.row]
        switch rowModel {
        case .heroImage:
            return CGFloat(200)
        default:
            return CGFloat(44)
        }
    }
}
