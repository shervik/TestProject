//
//  MatchesViewModel.swift
//  TestProject
//
//  Created by Виктория Щербакова on 04.03.2022.
//

import Foundation

protocol MatchesViewModelProtocol: AnyObject {
    var matches: [Match] { get }
    func fetchMatches(date: Date, completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> TableViewCellViewModelProtocol
}

class MatchesViewModel: MatchesViewModelProtocol {
    func cellViewModel(at indexPath: IndexPath) -> TableViewCellViewModelProtocol {
        let matches = matches[indexPath.row]
        return TableViewCellViewModel(matches: matches)
    }
    
    var matches: [Match] = []

    func fetchMatches(date: Date, completion: @escaping () -> Void) {
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
