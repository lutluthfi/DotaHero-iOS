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
        self.listView.collectionView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
        self.view = self._view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(view: self.listView, viewModel: self.viewModel)
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

    // MARK: Bind View & ViewModel Function
    private func bind(view: BSListView, viewModel: BSListViewModel) {
        self.bindShowedHeroStatsToHeroStatsAndHeroRoles(observables: viewModel.showedHeroStats,
                                                        heroStatsSubject: self.showedHeroStats,
                                                        heroRolesSubject: self.showedHeroRoles)
        self.bindHeroStatsToCollectionView(observables: self.showedHeroStats, collectionView: view.collectionView)
        self.bindHeroRolesToTableView(observables: self.showedHeroRoles, tableView: view.tableView)
        self.bindCollectionViewModelSelected(collectionView: view.collectionView)
        self.bindTableViewModelSelected(tableView: view.tableView)
        self.bindTableViewItemSelected(tableView: view.tableView)
        self.bindTableViewItemDeselected(tableView: view.tableView)
        self.bindTableViewWillDisplayCell(tableView: view.tableView)
    }
    
}

// MARK: Bind Function
extension BSListController {
    
    func bindCollectionViewModelSelected(collectionView: UICollectionView) {
        collectionView.rx
            .modelSelected(HeroStatDomain.self)
            .asDriver()
            .drive(onNext: { [unowned self] (heroStat) in
                self.viewModel.doSelect(heroStat: heroStat)
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindHeroRolesToTableView(observables: Observable<[String]>, tableView: UITableView) {
        let dataSource = self.makeRxTableViewDataSource()
        observables
            .map({ [SectionItemDomain(footer: nil, header: nil, items: $0)] })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
    func bindHeroStatsToCollectionView(observables: Observable<[HeroStatDomain]>, collectionView: UICollectionView) {
        let dataSource = self.makeRxCollectionViewDataSource()
        observables
            .map { [HeroStatSectionModel(model: "", items: $0)] }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
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
    
    func bindTableViewItemDeselected(tableView: UITableView) {
        tableView.rx
            .itemDeselected
            .asDriver()
            .drive { [unowned tableView] (indexPath) in
                tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: self.disposeBag)
    }
    
    func bindTableViewItemSelected(tableView: UITableView) {
        tableView.rx
            .itemSelected
            .asDriver()
            .drive { [unowned tableView] (indexPath) in
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            }
            .disposed(by: self.disposeBag)
    }
    
    func bindTableViewModelSelected(tableView: UITableView) {
        tableView.rx
            .modelSelected(String.self)
            .asDriver()
            .drive { [unowned self] (heroRole) in
                self.listView.setNavigationItemTitle(self.navigationItem, title: heroRole)
                self.viewModel.doSelect(heroRole: heroRole)
            }
            .disposed(by: self.disposeBag)
    }
    
    func bindTableViewWillDisplayCell(tableView: UITableView) {
        tableView.rx
            .willDisplayCell
            .asDriver()
            .drive { (event) in
                let cell = event.cell as! BSLHeroTableCell
                let isCellSelected = event.indexPath == tableView.indexPathForSelectedRow
                cell.isSelected = isCellSelected ? true : false
            }
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: RxTableViewSectionedReloadDataSource | BSLHeroTableCell
extension BSListController {
    
    func makeRxTableViewDataSource() -> RxTableViewSectionedReloadDataSource<SectionItemDomain<String>> {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionItemDomain<String>>
        { (_, tableView, _, item) -> BSLHeroTableCell in
            let cell = BSLHeroTableCell(style: .subtitle)
            cell.roleLabel.text = item
            return cell
        }
        return dataSource
    }
    
}

// MARK: RxCollectionViewSectionedReloadDataSource | BSLHeroCollectionCell
extension BSListController {
    
    func makeRxCollectionViewDataSource() -> RxCollectionViewSectionedAnimatedDataSource<HeroStatSectionModel> {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<HeroStatSectionModel>
        { (_, collectionView, indexPath, item) -> BSLHeroCollectionCell in
            let identifier = BSLHeroCollectionCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
            guard let cell = reusableCell as? BSLHeroCollectionCell else {
                fatalError("Cannot dequeueReusableCell with identifier: \(identifier)")
            }
            cell.fill(with: item)
            return cell
        }
        return dataSource
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension BSListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(4)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 3) - 2
        let height = width
        return CGSize(width: width, height: height)
    }
    
}
