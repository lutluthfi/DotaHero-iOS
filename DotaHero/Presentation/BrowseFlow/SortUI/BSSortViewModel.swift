//
//  BSSortViewModel.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/05/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation
import RxSwift

// MARK: BSSortViewModelResponse
public struct BSSortViewModelResponse {
    public let selectedFactor = PublishSubject<String>()
}

// MARK: BSSortViewModelRequest
public struct BSSortViewModelRequest {
}

// MARK: BSSortViewModelRoute
public struct BSSortViewModelRoute {
}

// MARK: BSSortViewModelInput
protocol BSSortViewModelInput {
    func viewDidLoad()
    func doSelect(factor: String)
}

// MARK: BSSortViewModelOutput
protocol BSSortViewModelOutput {

}

// MARK: BSSortViewModel
protocol BSSortViewModel: BSSortViewModelInput, BSSortViewModelOutput { }

// MARK: DefaultBSSortViewModel
final class DefaultBSSortViewModel: BSSortViewModel {

    // MARK: DI Variable
    let request: BSSortViewModelRequest
    let response: BSSortViewModelResponse
    let route: BSSortViewModelRoute

    // MARK: UseCase Variable



    // MARK: Common Variable

    

    // MARK: Output ViewModel
    

    // MARK: Init Function
    init(request: BSSortViewModelRequest,
         response: BSSortViewModelResponse,
         route: BSSortViewModelRoute) {
        self.request = request
        self.response = response
        self.route = route
    }
    
}

// MARK: Input ViewModel
extension DefaultBSSortViewModel {
    
    func viewDidLoad() {
    }
    
    func doSelect(factor: String) {
        self.response.selectedFactor.onNext(factor)
    }
    
}
