//
//  BSListController+BindHeroRolesToRoleCollectionView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/05/21.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

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
