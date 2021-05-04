//
//  BSListController.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

// MARK: BSListController
final class BSListController: UIViewController {
    
    // MARK: DI Variable
    lazy var listView: BSListView = DefaultBSListView()
    lazy var _view = (self.listView as! UIView)
    var viewModel: BSListViewModel!
    
    // MARK: Common Variable
    let disposeBag = DisposeBag()
    let showedHeroStats = PublishSubject<[HeroStatDomain]>()
    let showedHeroRoles = PublishSubject<[String]>()
    
    // MARK: Create Function
    class func create(with viewModel: BSListViewModel) -> BSListController {
        let controller = BSListController()
        controller.viewModel = viewModel
        return controller
    }
    
    // MARK: UIViewController Function
    override func loadView() {
        self.listView.heroCollectionView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
        self.listView.roleCollectionView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
        self.view = self._view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindShowedHeroStatsToHeroStatsAndHeroRoles(observables: self.viewModel.showedHeroStats,
                                                        heroStatsSubject: self.showedHeroStats,
                                                        heroRolesSubject: self.showedHeroRoles)
        self.bindHeroStatsToHeroCollectionView(observables: self.showedHeroStats,
                                               collectionView: self.listView.heroCollectionView)
        self.bindHeroRolesToRoleCollectionView(observables: self.showedHeroRoles,
                                               collectionView: self.listView.roleCollectionView)
        self.bindHeroCollectionViewModelSelected(collectionView: self.listView.heroCollectionView)
        self.bindRoleCollectionViewWillDisplayCell(collectionView: self.listView.roleCollectionView)
        self.bindRoleCollectionViewModelSelected(collectionView: self.listView.roleCollectionView)
        self.bindRoleCollectionViewItemDeselected(collectionView: self.listView.roleCollectionView)
        self.bindRoleCollectionViewItemSelected(collectionView: self.listView.roleCollectionView)
        self.listView.viewDidLoad(navigationBar: self.navigationController?.navigationBar,
                                  navigationItem: self.navigationItem,
                                  tabBarController: self.tabBarController)
        self.viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.listView.viewWillAppear(navigationBar: self.navigationController?.navigationBar,
                                     navigationItem: self.navigationItem,
                                     tabBarController: self.tabBarController)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.listView.viewWillDisappear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guaranteeMainThread {
            self.listView.roleCollectionView.reloadData()
            self.listView.heroCollectionView.reloadData()
        }
    }
    
}

// MARK: BindHeroRolesToRoleCollectionView
extension BSListController {
    
    func bindHeroRolesToRoleCollectionView(observables: Observable<[String]>, collectionView: UICollectionView) {
        let dataSource = self.makeHeroRoleDataSource()
        observables
            .map({ [SectionDomain<String>(header: "", footer: "", items: $0)] })
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
    private func makeHeroRoleDataSource() -> RxCollectionViewSectionedAnimatedDataSource<SectionDomain<String>> {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionDomain<String>>
        { (_, collectionView, index, item) -> UICollectionViewCell in
            let identifier = BSLSRoleCollectionCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: index)
            guard let cell = reusableCell as? BSLSRoleCollectionCell else {
                fatalError("Cannot dequeueReusableCell with identifier: \(identifier)")
            }
            cell.fill(with: item)
            return cell
        }
        return dataSource
    }
    
}

// MARK: BindHeroCollectionViewModelSelected
extension BSListController {
    
    func bindHeroCollectionViewModelSelected(collectionView: UICollectionView) {
        collectionView.rx
            .modelSelected(HeroStatDomain.self)
            .asDriver()
            .drive(onNext: { [unowned self] (hero) in
                self.viewModel.doSelect(heroStat: hero)
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: BindHeroStatsToHeroCollectionView
extension BSListController {
    
    func bindHeroStatsToHeroCollectionView(observables: Observable<[HeroStatDomain]>, collectionView: UICollectionView) {
        let dataSource = self.makeHeroStatDataSource()
        observables
            .map { [SectionDomain<HeroStatDomain>(header: "", footer: "", items: $0)] }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
    private func makeHeroStatDataSource() -> RxCollectionViewSectionedAnimatedDataSource<SectionDomain<HeroStatDomain>> {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionDomain<HeroStatDomain>>
        { (_, collectionView, index, item) -> BSLSHeroCollectionCell in
            let identifier = BSLSHeroCollectionCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: index)
            guard let cell = reusableCell as? BSLSHeroCollectionCell else {
                fatalError("Cannot dequeueReusableCell with identifier: \(identifier)")
            }
            cell.fill(with: item)
            return cell
        }
        return dataSource
    }
    
}

// MARK: BindRoleCollectionViewItemDeselected
extension BSListController {
    
    func bindRoleCollectionViewItemDeselected(collectionView: UICollectionView) {
        collectionView.rx
            .itemDeselected
            .asDriver()
            .drive(onNext: { [unowned collectionView] (index) in
                collectionView.deselectItem(at: index, animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: BindRoleCollectionViewItemSelected
extension BSListController {
    
    func bindRoleCollectionViewItemSelected(collectionView: UICollectionView) {
        collectionView.rx
            .itemSelected
            .asDriver()
            .drive(onNext: { [unowned collectionView] (index) in
                collectionView.selectItem(at: index, animated: true, scrollPosition: [])
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: BindRoleCollectionViewModelSelected
extension BSListController {
    
    func bindRoleCollectionViewModelSelected(collectionView: UICollectionView) {
        collectionView.rx
            .modelSelected(String.self)
            .asDriver()
            .drive(onNext: { [unowned self] (heroRole) in
                self.listView.setNavigationItemTitle(self.navigationItem, title: heroRole)
                self.viewModel.doSelect(heroRole: heroRole)
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: BindRoleCollectionViewWillDisplayCell
extension BSListController {
    
    func bindRoleCollectionViewWillDisplayCell(collectionView: UICollectionView) {
        collectionView.rx
            .willDisplayCell
            .asDriver()
            .drive(onNext: { [unowned collectionView] (observable) in
                let cell = observable.cell as? BSLSRoleCollectionCell
                let isCellSelected = collectionView.indexPathsForSelectedItems?.contains(observable.at)
                cell?.isSelected = isCellSelected == true
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: BindShowedHeroStatsToHeroStatsAndHeroRoles
extension BSListController {
    
    func bindShowedHeroStatsToHeroStatsAndHeroRoles(observables: Observable<[HeroStatDomain]>,
                                                    heroStatsSubject: PublishSubject<[HeroStatDomain]>,
                                                    heroRolesSubject: PublishSubject<[String]>) {
        observables
            .subscribeOn(ConcurrentMainScheduler.instance)
            .bind { (heroStats) in
                heroStatsSubject.onNext(heroStats)
                heroRolesSubject.onNext(heroStats.populateRoles())
            }
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension BSListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case self.listView.heroCollectionView:
            return CGFloat(2)
        case self.listView.roleCollectionView:
            return CGFloat(2)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case self.listView.heroCollectionView:
            return CGFloat(4)
        case self.listView.roleCollectionView:
            return CGFloat(4)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.listView.heroCollectionView:
            let width = (collectionView.bounds.width / 3) - 2
            let height = width
            return CGSize(width: width, height: height)
        case self.listView.roleCollectionView:
            switch UIDevice.current.orientation {
            case .landscapeLeft, .landscapeRight:
                let width = collectionView.bounds.width - 2
                let height = CGFloat(44)
                return CGSize(width: width, height: height)
            default:
                let width = (collectionView.bounds.width / 5) - 2
                let height = collectionView.bounds.height
                return CGSize(width: width, height: height)
            }
        default:
            return .zero
        }
        
    }
    
}
