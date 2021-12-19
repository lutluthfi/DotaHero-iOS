//
//  Thread.swift
//  HealthDiary
//
//  Created by Arif Luthfiansyah on 20/03/21.
//

import Foundation

public func guaranteeMainThread(_ work: @escaping () -> Void) {
    Thread.isMainThread ? work() : DispatchQueue.main.async(execute: work)
}
