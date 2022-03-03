//
//  MatchesPresenter.swift
//  TestProject
//
//  Created by Виктория Щербакова on 02.03.2022.
//

import Foundation

protocol MatchViewProtocol: AnyObject {
    func success()
    func failure(error: NetworkError)
}

protocol MatchesPresenterProtocol: AnyObject {
    init(view: MatchViewProtocol, networkManager: NetworkManagerProtocol, date: Date)
    func getMatches(date: Date)
    var matches: [Match]? { get set }
}

class MatchesPresenter: MatchesPresenterProtocol {
    weak var view: MatchViewProtocol?
    let networkManager: NetworkManagerProtocol
    var matches: [Match]?

    required init(view: MatchViewProtocol, networkManager: NetworkManagerProtocol, date: Date) {
        self.view = view
        self.networkManager = networkManager
        getMatches(date: date)
    }
    
    func getMatches(date: Date) {
        networkManager.getMatches(date: date) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let matches):
                    self?.matches = matches
                    self?.view?.success()
                    
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
}
