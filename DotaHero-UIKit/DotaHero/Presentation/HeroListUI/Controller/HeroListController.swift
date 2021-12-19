//
//  HeroListController.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import DTCommonModule
import DTDomainModule
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class HeroListController: UIViewController {
    typealias HeroDataSource = RxCollectionAnimatedDataSource<SectionDomain<HeroDomain>>
    typealias HeroRolesDataSource = RxCollectionAnimatedDataSource<SectionDomain<String>>
    
    lazy var listView: HeroListView = HeroListViewImpl()
    lazy var _view = (listView as! UIView)
    var viewModel: HeroListViewModel!
    
    let disposeBag = DisposeBag()
    let showedHeroStats = PublishSubject<[HeroDomain]>()
    let showedHeroRoles = PublishSubject<[String]>()
    
    class func create(with viewModel: HeroListViewModel) -> HeroListController {
        let controller = HeroListController()
        controller.viewModel = viewModel
        return controller
    }
    
    override func loadView() {
        listView.heroCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        listView.roleCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSortBarButtonItemTap(barButtonItem: listView.sortBarButtonItem)
        bindShowedHeroStatsToHeroStatsAndHeroRoles(
            relay: viewModel.showedHeroStats,
            heroStatsSubject: showedHeroStats,
            heroRolesSubject: showedHeroRoles
        )
        bindHeroStatsToHeroCollectionView(
            observables: showedHeroStats,
            collectionView: listView.heroCollectionView
        )
        bindHeroRolesToRoleCollectionView(
            observables: showedHeroRoles,
            collectionView: listView.roleCollectionView
        )
        bindHeroCollectionViewModelSelected(collectionView: listView.heroCollectionView)
        bindRoleCollectionViewWillDisplayCell(collectionView: listView.roleCollectionView)
        bindRoleCollectionViewModelSelected(collectionView: listView.roleCollectionView)
        bindRoleCollectionViewItemDeselected(collectionView: listView.roleCollectionView)
        bindRoleCollectionViewItemSelected(collectionView: listView.roleCollectionView)
        listView.viewDidLoad(
            navigationController: navigationController,
            navigationItem: navigationItem,
            tabBarController: tabBarController,
            toolbarItems: &toolbarItems
        )
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listView.viewWillAppear(
            navigationBar: navigationController?.navigationBar,
            navigationItem: navigationItem,
            tabBarController: tabBarController
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listView.viewWillDisappear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guaranteeMainThread { [weak self] in
            guard let self = self else {
                return
            }
            self.listView.roleCollectionView.reloadData()
            self.listView.heroCollectionView.reloadData()
        }
    }
}

extension HeroListController {
    func bindHeroCollectionViewModelSelected(collectionView: UICollectionView) {
        collectionView.rx
            .modelSelected(HeroDomain.self)
            .asDriver()
            .drive(onNext: { [unowned self] (hero) in
                viewModel.doSelect(hero: hero)
            })
            .disposed(by: disposeBag)
    }
}

extension HeroListController {
    func bindRoleCollectionViewItemDeselected(collectionView: UICollectionView) {
        collectionView.rx
            .itemDeselected
            .asDriver()
            .drive(onNext: { [unowned collectionView] (index) in
                collectionView.deselectItem(at: index, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension HeroListController {
    func bindRoleCollectionViewItemSelected(collectionView: UICollectionView) {
        collectionView.rx
            .itemSelected
            .asDriver()
            .drive(onNext: { [unowned collectionView] (index) in
                collectionView.selectItem(at: index, animated: true, scrollPosition: [])
            })
            .disposed(by: disposeBag)
    }
}

extension HeroListController {
    func bindRoleCollectionViewModelSelected(collectionView: UICollectionView) {
        collectionView.rx
            .modelSelected(String.self)
            .asDriver()
            .drive(onNext: { [unowned self] (heroRole) in
                listView.setNavigationItemTitle(navigationItem, title: heroRole)
                viewModel.doSelect(heroRole: heroRole)
            })
            .disposed(by: disposeBag)
    }
}

extension HeroListController {
    func bindRoleCollectionViewWillDisplayCell(collectionView: UICollectionView) {
        collectionView.rx
            .willDisplayCell
            .asDriver()
            .drive(onNext: { [unowned collectionView] (observable) in
                let cell = observable.cell as? HeroListRoleItemCollectionCell
                let position: IndexPath = observable.at
                let isCellSelected = collectionView.indexPathsForSelectedItems?.contains(position)
                cell?.isSelected = isCellSelected == true
            })
            .disposed(by: disposeBag)
    }
}

extension HeroListController {
    func bindShowedHeroStatsToHeroStatsAndHeroRoles(
        relay: BehaviorRelay<[HeroDomain]>,
        heroStatsSubject: PublishSubject<[HeroDomain]>,
        heroRolesSubject: PublishSubject<[String]>
    ) {
        relay
            .asDriver()
            .drive(onNext: { (hero) in
                heroStatsSubject.onNext(hero)
                heroRolesSubject.onNext(hero.populateRoles())
            })
            .disposed(by: disposeBag)
    }
}

extension HeroListController {
    func bindSortBarButtonItemTap(barButtonItem: UIBarButtonItem) {
        barButtonItem.rx
            .tap
            .asDriver()
            .drive(onNext: { [unowned self] (_) in
                viewModel.presentSortUI()
            })
            .disposed(by: disposeBag)
    }
}
