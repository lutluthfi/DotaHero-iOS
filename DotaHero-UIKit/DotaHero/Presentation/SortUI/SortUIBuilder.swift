//
//  SortUIBuilder.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 20/12/21.
//

import UIKit

public struct SortUIBuilder {
    private let controller: SortController
    private let navigationController: UINavigationController
    
    public init(
        _ navigationController: UINavigationController,
        request: SortViewModelRequest,
        response: SortViewModelResponse
    ) {
        self.navigationController = navigationController
        let viewModel = SortViewModelImpl(request: request, response: response)
        controller = SortController.create(with: viewModel)
    }
    
    func build() -> UIViewController {
        UINavigationController(rootViewController: controller)
    }
}
