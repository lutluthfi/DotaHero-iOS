//
//  SortController.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/05/21.
//  Copyright (c) 2021 All rights reserved.
//

import DTDomainModule
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class SortController: UITableViewController {
    typealias FactorDataSource = RxTableAnimatedDataSource<SectionDomain<String>>
    
    let disposeBag = DisposeBag()
    lazy var sortView: SortView = SortViewImpl()
    var viewModel: SortViewModel!
    
    let _selectedFactor = PublishSubject<String>()
    
    class func create(with viewModel: SortViewModel) -> SortController {
        let controller = SortController()
        controller.viewModel = viewModel
        return controller
    }
    
    override func loadView() {
        view = sortView.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindApplyBarButtonItemTap(barButtonItem: sortView.applyBarButtonItem)
        bindTableViewModelSelected(tableView: sortView.tableView)
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sortView.viewWillAppear(
            navigationBar: navigationController?.navigationBar,
            navigationItem: navigationItem,
            tabBarController: tabBarController
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindFactorsToTableView(
            observable: .just(sortView.factors),
            tableView: sortView.tableView
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sortView.viewWillDisappear()
    }
}

extension SortController {
    func bindApplyBarButtonItemTap(barButtonItem: UIBarButtonItem) {
        barButtonItem.rx
            .tap
            .withLatestFrom(_selectedFactor)
            .bind(onNext: { [unowned self] (factor) in
                viewModel.doSelect(factor: factor)
                dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension SortController {
    func bindFactorsToTableView(observable: Observable<[String]>, tableView: UITableView) {
        let dataSource = makeTableViewDataSource()
        observable
            .asDriver(onErrorJustReturn: [])
            .map({ [SectionDomain(header: "", footer: "", items: $0)] })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func makeTableViewDataSource() -> FactorDataSource {
        let dataSource = FactorDataSource { (_, _, _, item) -> UITableViewCell in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "DefaultTableCell")
            cell.textLabel?.text = item
            return cell
        }
        return dataSource
    }
}

extension SortController {
    func bindTableViewModelSelected(tableView: UITableView) {
        tableView.rx
            .modelSelected(String.self)
            .asDriver()
            .drive(_selectedFactor)
            .disposed(by: disposeBag)
    }
}
