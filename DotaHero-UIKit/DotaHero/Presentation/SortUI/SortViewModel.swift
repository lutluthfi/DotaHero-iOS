//
//  SortViewModel.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/05/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation
import RxSwift

public struct SortViewModelResponse {
    public let selectedFactor = PublishSubject<String>()
}

public struct SortViewModelRequest {
}

protocol SortViewModelInput {
    func viewDidLoad()
    func doSelect(factor: String)
}

protocol SortViewModelOutput {
}

protocol SortViewModel: SortViewModelInput, SortViewModelOutput { }

final class SortViewModelImpl: SortViewModel {
    
    let request: SortViewModelRequest
    let response: SortViewModelResponse
    
    init(
        request: SortViewModelRequest,
        response: SortViewModelResponse
    ) {
        self.request = request
        self.response = response
    }
}

extension SortViewModelImpl {
    func viewDidLoad() {
    }
    
    func doSelect(factor: String) {
        response.selectedFactor.onNext(factor)
    }
}
