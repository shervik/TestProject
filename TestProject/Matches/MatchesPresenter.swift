//
//  MatchesPresenter.swift
//  TestProject
//
//  Created by Виктория Щербакова on 04.03.2022.
//

import Foundation

class MatchesPresenter: MatchesViewOutputProtocol {
    weak var view: MatchesViewInputProtocol?
    var interactor: MatchesInteractorInputProtocol?
    var router: MatchesRouterInputProtocol?
    
    var menuItems: [DateSegment] = [
        DateSegment(title: "Вчера", date: .yesterday),
        DateSegment(title: "Сегодня", date: .today),
        DateSegment(title: "Завтра", date: .tomorrow)
    ]
    
    required init(view: MatchesViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad(date: Date) {
        interactor?.viewChangedData(date: date)
    }
    
}

extension MatchesPresenter: MatchesInteractorOutputProtocol {
    func matchesDidReceive(_ matches: [Match]) {
        let section = MatchesSectionViewModel()
        matches.forEach { section.rows.append(MatchesCellViewModel(matches: $0)) }
        view?.reloadDataForSection(for: section)
    }
    
}
