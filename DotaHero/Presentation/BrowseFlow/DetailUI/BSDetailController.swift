//
//  BSDetailController.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

// MARK: BSDetailController
final class BSDetailController: UITableViewController {
    
    // MARK: DI Variable
    lazy var detailView: BSDetailView = DefaultBSDetailView()
    let disposeBag = DisposeBag()
    var viewModel: BSDetailViewModel!
    
    // MARK: Common Variable
    let showedHeroStat = BehaviorRelay<HeroStatDomain?>(value: nil)
    
    // MARK: Create Function
    class func create(with viewModel: BSDetailViewModel) -> BSDetailController {
        let controller = BSDetailController()
        controller.viewModel = viewModel
        return controller
    }
    
    // MARK: UIViewController Function
    override func loadView() {
        self.view = self.detailView.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindTableViewDelegate(tableView: self.detailView.tableView)
        self.bindShowedHeroStat(relay: self.viewModel.showedHeroStat)
        self.bindShowedHeroStatToNavigationItemTitle(relay: self.showedHeroStat, navigationItem: self.navigationItem)
        self.viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.detailView.viewWillAppear(navigationBar: self.navigationController?.navigationBar,
                                       navigationItem: self.navigationItem,
                                       tabBarController: self.tabBarController)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.bindHeroStatToTableView(observable: .just(self.detailView.tableSections),
                                     tableView: self.detailView.tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.detailView.viewWillDisappear()
    }
    
}

// MARK: BindShowedHeroStat
extension BSDetailController {
    
    func bindShowedHeroStat(relay: PublishRelay<HeroStatDomain>) {
        relay
            .do(onNext: { [unowned self] (heroStat) in
                var roles: [TableRowDomain] = []
                heroStat.roles.forEach { (_) in
                    roles.append(.role)
                }
                let section = SectionDomain(header: "Role", footer: "", items: roles)
                self.detailView.insertNewSection(section)
            })
            .bind(to: self.showedHeroStat)
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: BindShowedHeroStatToNavigationItemTitle
extension BSDetailController {
    
    func bindShowedHeroStatToNavigationItemTitle(relay: BehaviorRelay<HeroStatDomain?>,
                                                 navigationItem: UINavigationItem) {
        relay
            .asDriver()
            .compactMap({ $0?.heroName })
            .drive(navigationItem.rx.title)
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: BindHeroStatToTableView
extension BSDetailController {
    
    func bindHeroStatToTableView(observable: Observable<[SectionDomain<TableRowDomain>]>, tableView: UITableView) {
        let dataSource = self.makeTableViewDataSource()
        observable
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
    private func makeTableViewDataSource() -> RxTableViewSectionedAnimatedDataSource<SectionDomain<TableRowDomain>> {
        let dataSource = RxTableViewSectionedAnimatedDataSource<SectionDomain<TableRowDomain>>
        { [unowned self] (_, _, index, item) -> UITableViewCell in
            switch item {
            case .attackType:
                let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
                cell.textLabel?.text = item.placeholder
                let attackType = self.showedHeroStat.value?.attackType ?? ""
                cell.detailTextLabel?.text = attackType
                return cell
            case .baseArmor:
                let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
                cell.imageView?.image = self.makeImage(with: "🛡")
                cell.textLabel?.text = item.placeholder
                let baseArmor = self.showedHeroStat.value?.baseArmor ?? 0
                cell.detailTextLabel?.text = String(baseArmor)
                return cell
            case .baseAttack:
                let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
                cell.imageView?.image = self.makeImage(with: "⚔️")
                cell.textLabel?.text = item.placeholder
                let baseAttackMin = self.showedHeroStat.value?.baseAttackMin ?? 0
                let baseAttackMax = self.showedHeroStat.value?.baseAttackMax ?? 0
                cell.detailTextLabel?.text = "\(baseAttackMin) - \(baseAttackMax)"
                return cell
            case .baseHealth:
                let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
                cell.imageView?.image = self.makeImage(with: "➕")
                cell.textLabel?.text = item.placeholder
                let baseHealth = self.showedHeroStat.value?.baseHealth ?? 0
                cell.detailTextLabel?.text = String(baseHealth)
                return cell
            case .baseMana:
                let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
                cell.imageView?.image = self.makeImage(with: "🍶")
                cell.textLabel?.text = item.placeholder
                let baseMana = self.showedHeroStat.value?.baseMana ?? 0
                cell.detailTextLabel?.text = String(baseMana)
                return cell
            case .heroImage:
                let cell = BSDTPhotoTableCell()
                cell.fill(with: URL(string: self.showedHeroStat.value?.image ?? "")!)
                return cell
            case .heroName:
                let cell =  UITableViewCell(style: .subtitle, reuseIdentifier: "SubtitleTableCell")
                let imageURL = URL(string: self.showedHeroStat.value?.image ?? "")!
                cell.imageView?.kf.indicatorType = .activity
                cell.imageView?.kf.setImage(with: imageURL, options: [.cacheOriginalImage])
                cell.textLabel?.text = self.showedHeroStat.value?.heroName
                cell.detailTextLabel?.text = self.showedHeroStat.value?.primaryAttribute.uppercased()
                return cell
            case .moveSpeed:
                let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
                cell.imageView?.image = self.makeImage(with: "🥾")
                cell.textLabel?.text = item.placeholder
                let moveSpeed = self.showedHeroStat.value?.moveSpeed ?? 0
                cell.detailTextLabel?.text = String(moveSpeed)
                return cell
            case .role:
                let cell =  UITableViewCell(style: .default, reuseIdentifier: "DefaultTableCell")
                cell.textLabel?.text = self.showedHeroStat.value?.roles[index.row]
                return cell
            default:
                let cell =  UITableViewCell(style: .default, reuseIdentifier: "DefaultTableCell")
                
                return cell
            }
        }
        return dataSource
    }
    
    private func makeImage(with string: String) -> UIImage? {
        return string.image(withAttributes: [.font: UIFont.systemFont(ofSize: 22)],
                            size: CGSize(width: 30, height: 30))
    }
    
}

// MARK: BindTableViewDelegate
extension BSDetailController {
    
    func bindTableViewDelegate(tableView: UITableView) {
        tableView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: UITableViewDelegate
extension BSDetailController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowModel = self.detailView.tableSections[indexPath.section].items[indexPath.row]
        switch rowModel {
        case .heroImage:
            return CGFloat(200)
        default:
            return CGFloat(44)
        }
    }
    
}
