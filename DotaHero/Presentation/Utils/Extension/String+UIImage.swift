//
//  String+UIImage.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import UIKit

extension String {
    
    func image(withAttributes attributes: [NSAttributedString.Key: Any]? = nil,
               size: CGSize? = nil) -> UIImage? {
        let size = size ?? (self as NSString).size(withAttributes: attributes)
        UIGraphicsBeginImageContext(size)
        (self as NSString).draw(in: CGRect(origin: .zero, size: size), withAttributes: attributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
