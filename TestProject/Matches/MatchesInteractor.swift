//
//  MatchesInteractor.swift
//  TestProject
//
//  Created by Виктория Щербакова on 04.03.2022.
//

import Foundation

protocol MatchesInteractorInputProtocol: AnyObject {
    init(presenter: MatchesInteractorOutputProtocol)
    func viewChangedData(date: Date)
}

protocol MatchesInteractorOutputProtocol: AnyObject {
    func matchesDidReceive(_ matches: [Match])
}

class MatchesInteractor: MatchesInteractorInputProtocol {
    weak var presenter: MatchesInteractorOutputProtocol?
    
    required init(presenter: MatchesInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func viewChangedData(date: Date) {
        NetworkManager().getMatches(date: date) { [weak self] result in
            switch result {
            case .success(matches: let matches):
                self?.presenter?.matchesDidReceive(matches)
                
            case .failure(let error):
                print("Error: \(String(describing: error))")
            }
        }
    }
}
