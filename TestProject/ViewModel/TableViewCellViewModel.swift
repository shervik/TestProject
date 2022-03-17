//
//  TableViewCellViewModel.swift
//  TestProject
//
//  Created by Виктория Щербакова on 04.03.2022.
//

import Foundation

protocol TableViewCellViewModelProtocol {
    var homeTeamName: String { get }
    var awayTeamName: String { get }
    var scoreMatch: String { get }
    var status: String { get }
    init(matches: Match)
}

class TableViewCellViewModel: TableViewCellViewModelProtocol {
    private let matches: Match

    var homeTeamName: String {
        matches.homeTeam?.name ?? ""
    }
    
    var awayTeamName: String {
        matches.awayTeam?.name ?? ""
    }
    
    var scoreMatch: String {
        let homeScore = matches.score?.fullTime?.homeTeam ?? 0
        let awayScore = matches.score?.fullTime?.awayTeam ?? 0
        return "\(homeScore) : \(awayScore)"
    }
    
    var status: String {
        matches.status ?? ""
    }
    
    required init(matches: Match) {
        self.matches = matches
    }
    
    
}
