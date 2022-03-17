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
    var matches: [Match] { get }
    var viewMatch: [CellModel] { get }
    var menuItems: [DateSegment] { get }
    var title: String { get }
    
    init(view: MatchViewProtocol, networkManager: NetworkManagerProtocol, date: Date)
    func viewChangedData(date: Date)
}

class MatchesPresenter: MatchesPresenterProtocol {
    weak var view: MatchViewProtocol?
    let menuItems: [DateSegment] = [
        DateSegment(title: "Вчера", date: .yesterday),
        DateSegment(title: "Сегодня", date: .today),
        DateSegment(title: "Завтра", date: .tomorrow)
    ]
    let networkManager: NetworkManagerProtocol
    var matches: [Match] = []
    var title: String = "Title"
    var viewMatch: [CellModel] = []

    required init(view: MatchViewProtocol, networkManager: NetworkManagerProtocol, date: Date) {
        self.view = view
        self.networkManager = networkManager
        viewChangedData(date: date)
    }
    
    func viewChangedData(date: Date) {
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
