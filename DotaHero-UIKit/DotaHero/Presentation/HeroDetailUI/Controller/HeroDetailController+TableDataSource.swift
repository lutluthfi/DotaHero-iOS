//
//  HeroDetailController+TableDataSource.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 17/12/21.
//

import DTDomainModule
import RxSwift
import UIKit

extension HeroDetailController {
    func bindHeroStatToTableView(
        observable: Observable<[SectionDomain<TableRowDomain>]>,
        tableView: UITableView
    ) {
        let dataSource = makeTableViewDataSource()
        observable
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func makeTableViewDataSource() -> TableDataSource {
        let dataSource = TableDataSource
        { [unowned self] (_, _, index, item) -> UITableViewCell in
            switch item {
            case .attackType:
                return renderAttackTypeCell(fillWith: item)
            case .baseArmor:
               return renderBaseArmorCell(fillWith: item)
            case .baseAttack:
                return renderBaseAttackCell(fillWith: item)
            case .baseHealth:
                return renderBaseHealthCell(fillWith: item)
            case .baseMana:
                return renderBaseManaCell(fillWith: item)
            case .heroImage:
                return renderHeroImageCell()
            case .heroName:
               return renderHeroNameCell()
            case .moveSpeed:
                return renderMoveSpeedCell(fillWith: item)
            case .role:
                return renderRoleCell(forRowAt: index)
            default:
                let cell =  UITableViewCell(style: .default, reuseIdentifier: "DefaultTableCell")
                return cell
            }
        }
        return dataSource
    }
    
    private func renderAttackTypeCell(fillWith item: TableRowDomain) -> UITableViewCell {
        let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
        cell.textLabel?.text = item.placeholder
        let attackType = showedHeroes.value?.attackType ?? ""
        cell.detailTextLabel?.text = attackType
        return cell
    }
    
    private func renderBaseArmorCell(fillWith item: TableRowDomain) -> UITableViewCell {
        let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
        cell.imageView?.image = makeImage(with: "🛡")
        cell.textLabel?.text = item.placeholder
        let baseArmor = showedHeroes.value?.baseArmor ?? 0
        cell.detailTextLabel?.text = String(baseArmor)
        return cell
    }
    
    private func renderBaseAttackCell(fillWith item: TableRowDomain) -> UITableViewCell {
        let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
        cell.imageView?.image = makeImage(with: "⚔️")
        cell.textLabel?.text = item.placeholder
        let baseAttackMin = showedHeroes.value?.baseAttackMin ?? 0
        let baseAttackMax = showedHeroes.value?.baseAttackMax ?? 0
        cell.detailTextLabel?.text = "\(baseAttackMin) - \(baseAttackMax)"
        return cell
    }
    
    private func renderBaseHealthCell(fillWith item: TableRowDomain) -> UITableViewCell {
        let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
        cell.imageView?.image = makeImage(with: "➕")
        cell.textLabel?.text = item.placeholder
        let baseHealth = showedHeroes.value?.baseHealth ?? 0
        cell.detailTextLabel?.text = String(baseHealth)
        return cell
    }
    
    private func renderBaseManaCell(fillWith item: TableRowDomain) -> UITableViewCell {
        let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
        cell.imageView?.image = makeImage(with: "🍶")
        cell.textLabel?.text = item.placeholder
        let baseMana = showedHeroes.value?.baseMana ?? 0
        cell.detailTextLabel?.text = String(baseMana)
        return cell
    }
    
    private func renderHeroImageCell() -> UITableViewCell {
        let cell = HeroDetailPhotoTableCell()
        cell.fill(with: URL(string: showedHeroes.value?.image ?? "")!)
        return cell
    }
    
    private func renderHeroNameCell() -> UITableViewCell {
        let cell =  UITableViewCell(style: .subtitle, reuseIdentifier: "SubtitleTableCell")
        let imageURL = URL(string: showedHeroes.value?.image ?? "")!
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: imageURL, options: [.cacheOriginalImage])
        cell.textLabel?.text = showedHeroes.value?.heroName
        cell.detailTextLabel?.text = showedHeroes.value?.primaryAttribute.uppercased()
        return cell
    }
    
    private func renderMoveSpeedCell(fillWith item: TableRowDomain) -> UITableViewCell {
        let cell =  UITableViewCell(style: .value1, reuseIdentifier: "Value1TableCell")
        cell.imageView?.image = makeImage(with: "🥾")
        cell.textLabel?.text = item.placeholder
        let moveSpeed = showedHeroes.value?.moveSpeed ?? 0
        cell.detailTextLabel?.text = String(moveSpeed)
        return cell
    }
    
    private func renderRoleCell(forRowAt index: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: .default, reuseIdentifier: "DefaultTableCell")
        cell.textLabel?.text = showedHeroes.value?.roles[index.row]
        return cell
    }
    
    private func makeImage(with string: String) -> UIImage? {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 22)
        ]
        let size = CGSize(width: 30, height: 30)
        return string.image(withAttributes: attributes, size: size)
    }
}
