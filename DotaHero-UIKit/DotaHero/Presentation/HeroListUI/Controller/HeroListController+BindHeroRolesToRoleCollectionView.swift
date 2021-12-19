//
//  HeroListController+BindHeroRolesToRoleCollectionView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/05/21.
//

import DTDomainModule
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

extension HeroListController {
    func bindHeroRolesToRoleCollectionView(observables: Observable<[String]>, collectionView: UICollectionView) {
        let dataSource = makeHeroRoleDataSource()
        observables
            .map({ [SectionDomain<String>(header: "", footer: "", items: $0)] })
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func makeHeroRoleDataSource() -> HeroRolesDataSource {
        let dataSource = HeroRolesDataSource
        { (_, collectionView, index, item) -> UICollectionViewCell in
            let identifier = HeroListRoleItemCollectionCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: index)
            guard let cell = reusableCell as? HeroListRoleItemCollectionCell else {
                fatalError("Cannot dequeueReusableCell with identifier: \(identifier)")
            }
            cell.fill(with: item)
            return cell
        }
        return dataSource
    }
}
