//
//  PlainError.swift
//  HealthDiary
//
//  Created by Arif Luthfiansyah on 30/03/21.
//

import Foundation

public struct PlainError {
    
    public let code: Int
    public let description: String
    
    public init(code: Int = 0, description: String) {
        self.code = code
        self.description = description
    }
    
}

extension PlainError: LocalizedError {
    
    public var errorDescription: String? {
        return self.description
    }
    
}
