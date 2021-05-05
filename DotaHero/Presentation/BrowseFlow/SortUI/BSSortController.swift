//
//  BSSortController.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/05/21.
//  Copyright (c) 2021 All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

// MARK: BSSortController
final class BSSortController: UITableViewController {
    
    // MARK: DI Variable
    let disposeBag = DisposeBag()
    lazy var sortView: BSSortView = DefaultBSSortView()
    var viewModel: BSSortViewModel!
    
    // MARK: Common Variable
    let _selectedFactor = PublishSubject<String>()
    
    // MARK: Create Function
    class func create(with viewModel: BSSortViewModel) -> BSSortController {
        let controller = BSSortController()
        controller.viewModel = viewModel
        return controller
    }
    
    // MARK: UIViewController Function
    override func loadView() {
        self.view = self.sortView.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindApplyBarButtonItemTap(barButtonItem: self.sortView.applyBarButtonItem)
        self.bindTableViewModelSelected(tableView: self.sortView.tableView)
        self.viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sortView.viewWillAppear(navigationBar: self.navigationController?.navigationBar,
                                     navigationItem: self.navigationItem,
                                     tabBarController: self.tabBarController)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.bindFactorsToTableView(observable: .just(self.sortView.factors), tableView: self.sortView.tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.sortView.viewWillDisappear()
    }
    
}

// MARK: BindApplyBarButtonItemTap
extension BSSortController {
    
    func bindApplyBarButtonItemTap(barButtonItem: UIBarButtonItem) {
        barButtonItem.rx
            .tap
            .withLatestFrom(self._selectedFactor)
            .bind(onNext: { [unowned self] (factor) in
                self.viewModel.doSelect(factor: factor)
                self.dismiss(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: BindFactorsToTableView
extension BSSortController {
    
    func bindFactorsToTableView(observable: Observable<[String]>, tableView: UITableView) {
        let dataSource = self.makeTableViewDataSource()
        observable
            .asDriver(onErrorJustReturn: [])
            .map({ [SectionDomain(header: "", footer: "", items: $0)] })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
    private func makeTableViewDataSource() -> RxTableViewSectionedAnimatedDataSource<SectionDomain<String>> {
        let dataSource = RxTableViewSectionedAnimatedDataSource<SectionDomain<String>>
        { (_, _, _, item) -> UITableViewCell in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "DefaultTableCell")
            cell.textLabel?.text = item
            return cell
        }
        return dataSource
    }
    
}

// MARK: BindTableViewModelSelected
extension BSSortController {
    
    func bindTableViewModelSelected(tableView: UITableView) {
        tableView.rx
            .modelSelected(String.self)
            .asDriver()
            .drive(self._selectedFactor)
            .disposed(by: self.disposeBag)
    }
    
}
