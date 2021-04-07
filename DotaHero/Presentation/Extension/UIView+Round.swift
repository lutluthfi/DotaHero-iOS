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
        self.clipsToBounds = true
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRad
        if !maskedCorner.isEmpty {
            self.layer.maskedCorners = maskedCorner
        }
        return self
    }
    
}
