//
//  MatchesPresenter.swift
//  TestProject
//
//  Created by Виктория Щербакова on 04.03.2022.
//

import Foundation

struct MatchData {
    
}

class MatchesPresenter: MatchesViewOutputProtocol {
    weak var view: MatchesViewInputProtocol?
    var interactor: MatchesInteractorInputProtocol?
    var router: MatchesRouterInputProtocol?
    
    required init(view: MatchesViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad(date: Date) {
        interactor?.fetchMatches(date: date)
    }
    
}

extension MatchesPresenter: MatchesInteractorOutputProtocol {
    func matchesDidReceive(_ matches: [Match]) {
        let section = MatchesSectionViewModel()
        matches.forEach { section.rows.append(MatchesCellViewModel(matches: $0)) }
        view?.reloadDataForSection(for: section)
    }
    
}
