//
//  BSListController+BindHeroStatsToHeroCollectionView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/05/21.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

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
