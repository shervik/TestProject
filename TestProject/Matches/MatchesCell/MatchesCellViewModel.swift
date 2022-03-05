//
//  MatchesCellViewModel.swift
//  TestProject
//
//  Created by Виктория Щербакова on 05.03.2022.
//

import Foundation

protocol CellIdentifiable {
    var cellIdentifier: String { get }
    var cellHeight: Double { get }
    var cellSpacing: Double { get }
}

protocol SectionRowPresentable {
    var rows: [CellIdentifiable] { get set }
}

class MatchesCellViewModel: CellIdentifiable {
    let homeTeamName: String
    let awayTeamName: String
    let score: String
    let status: String
    
    var cellIdentifier: String {
        "cell"
    }
    
    var cellHeight: Double {
        100
    }
    
    var cellSpacing: Double {
        0
    }
    
    init(matches: Match) {
        homeTeamName = matches.homeTeam?.name ?? ""
        awayTeamName = matches.awayTeam?.name ?? ""
        let homeScore: Int = matches.score?.fullTime?.homeTeam ?? 0
        let awayScore: Int = matches.score?.fullTime?.awayTeam ?? 0
        score = "\(homeScore) : \(awayScore)"
        status = matches.status ?? ""
    }
}

class MatchesSectionViewModel: SectionRowPresentable {
    var rows: [CellIdentifiable] = []
}
