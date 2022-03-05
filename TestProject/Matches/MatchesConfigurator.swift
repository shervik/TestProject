//
//  MatchesConfigurator.swift
//  TestProject
//
//  Created by Виктория Щербакова on 04.03.2022.
//

import Foundation

protocol MatchesConfiguratorInputProtocol {
    func configure(with viewController: MatchesViewController)
}

class MatchesConfigurator: MatchesConfiguratorInputProtocol {
    func configure(with viewController: MatchesViewController) {
        let presenter = MatchesPresenter(view: viewController)
        let interactor = MatchesInteractor(presenter: presenter)
        let router = MatchesRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
