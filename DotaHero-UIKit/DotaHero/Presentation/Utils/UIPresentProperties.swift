//
//  UIPresentProperties.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/05/21.
//

import UIKit

public struct UIPresentProperties {
    
    public static let standard = UIPresentProperties()
    
    public let isModalInPresentation: Bool
    public let modalPresentationStyle: UIModalPresentationStyle
    public let modalTransitionStyle: UIModalTransitionStyle
    
    public init(
        isModalInPresentation: Bool = false,
        modalPresentationStyle: UIModalPresentationStyle = .automatic,
        modalTransitionStyle: UIModalTransitionStyle = .coverVertical
    ) {
        self.isModalInPresentation = isModalInPresentation
        self.modalPresentationStyle = modalPresentationStyle
        self.modalTransitionStyle = modalTransitionStyle
    }
    
}
