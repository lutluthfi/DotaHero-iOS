//
//  BSMasterViewModel.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/04/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation

// MARK: BSMasterViewModelResponse
enum BSMasterViewModelResponse {
}

// MARK: BSMasterViewModelDelegate
protocol BSMasterViewModelDelegate: class {
}

// MARK: BSMasterViewModelRequestValue
public struct BSMasterViewModelRequestValue {
}

// MARK: BSMasterViewModelRoute
public struct BSMasterViewModelRoute {
}

// MARK: BSMasterViewModelInput
protocol BSMasterViewModelInput {

    func viewDidLoad()

}

// MARK: BSMasterViewModelOutput
protocol BSMasterViewModelOutput {

}

// MARK: BSMasterViewModel
protocol BSMasterViewModel: BSMasterViewModelInput, BSMasterViewModelOutput { }

// MARK: DefaultBSMasterViewModel
final class DefaultBSMasterViewModel: BSMasterViewModel {

    // MARK: DI Variable
    weak var delegate: BSMasterViewModelDelegate?
    let requestValue: BSMasterViewModelRequestValue
    let route: BSMasterViewModelRoute

    // MARK: UseCase Variable



    // MARK: Common Variable

    

    // MARK: Output ViewModel
    

    // MARK: Init Function
    init(requestValue: BSMasterViewModelRequestValue,
         route: BSMasterViewModelRoute) {
        self.requestValue = requestValue
        self.route = route
    }
    
}

// MARK: Input ViewModel
extension DefaultBSMasterViewModel {
    
    func viewDidLoad() {
    }
    
}
