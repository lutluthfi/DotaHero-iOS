//
//  HeroListController+BindHeroStatsToHeroCollectionView.swift
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
    func bindHeroStatsToHeroCollectionView(
        observables: Observable<[HeroDomain]>,
        collectionView: UICollectionView
    ) {
        let dataSource = makeHeroStatDataSource()
        observables
            .map { [SectionDomain<HeroDomain>(header: "", footer: "", items: $0)] }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func makeHeroStatDataSource() -> HeroDataSource {
        let dataSource = HeroDataSource
        { (_, collectionView, index, item) -> HeroListItemCollectionCell in
            let identifier = HeroListItemCollectionCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: index)
            guard let cell = reusableCell as? HeroListItemCollectionCell else {
                fatalError("Cannot dequeueReusableCell with identifier: \(identifier)")
            }
            cell.fill(with: item)
            return cell
        }
        return dataSource
    }
}
