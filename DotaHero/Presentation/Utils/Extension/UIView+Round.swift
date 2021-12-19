//
//  UIView+Round.swift
//  HealthDiary
//
//  Created by Arif Luthfiansyah on 21/03/21.
//

import UIKit

public extension UIView {
    
    @discardableResult
    func makeRound(borderColor: UIColor? = nil,
                   borderWidth: CGFloat = 0,
                   cornerRad: CGFloat = 8,
                   maskedCorner: CACornerMask = []) -> UIView {
        clipsToBounds = true
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRad
        if !maskedCorner.isEmpty {
            layer.maskedCorners = maskedCorner
        }
        return self
    }
    
}
