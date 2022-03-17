//
//  MatchesViewModel.swift
//  TestProject
//
//  Created by Виктория Щербакова on 04.03.2022.
//

import Foundation

protocol MatchesViewModelProtocol: AnyObject {
    var matches: [Match] { get }
    var menuItems: [DateSegment] { get }
    var title: String { get }
    
    func viewChangedData(date: Date, completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> TableViewCellViewModelProtocol
}

class MatchesViewModel: MatchesViewModelProtocol {
    var matches: [Match] = []
    let menuItems: [DateSegment] = [
        DateSegment(title: "Вчера", date: .yesterday),
        DateSegment(title: "Сегодня", date: .today),
        DateSegment(title: "Завтра", date: .tomorrow)
    ]
    let title: String = "Title"
    
    func cellViewModel(at indexPath: IndexPath) -> TableViewCellViewModelProtocol {
        let matches = matches[indexPath.row]
        return TableViewCellViewModel(matches: matches)
    }
    
    func viewChangedData(date: Date, completion: @escaping () -> Void) {
        NetworkManager().getMatches(date: date) { [weak self] result in
            switch result {
            case .success(matches: let matches):
                self?.matches = matches
                
            case .failure(let error):
                print("Error: \(String(describing: error))")
            }
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        matches.count
    }
    
}
