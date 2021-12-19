//
//  HeroListController+UICollectionViewDelegateFlowLayout.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/05/21.
//

import UIKit

extension HeroListController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        switch collectionView {
        case listView.heroCollectionView:
            return CGFloat(2)
        case listView.roleCollectionView:
            return CGFloat(2)
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        switch collectionView {
        case listView.heroCollectionView:
            return CGFloat(4)
        case listView.roleCollectionView:
            return CGFloat(4)
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch collectionView {
        case listView.heroCollectionView:
            let width = (collectionView.bounds.width / 3) - 2
            let height = width
            return CGSize(width: width, height: height)
        case listView.roleCollectionView:
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

