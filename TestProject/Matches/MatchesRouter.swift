//
//  MatchesRouter.swift
//  TestProject
//
//  Created by Виктория Щербакова on 04.03.2022.
//

import Foundation

protocol MatchesRouterInputProtocol {
    init(viewController: MatchesViewController)
}

class MatchesRouter: MatchesRouterInputProtocol {
    weak var viewController: MatchesViewController?
    
    required init(viewController: MatchesViewController) {
        self.viewController = viewController
    }
    
}
