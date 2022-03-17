//
//  CellModel.swift
//  TestProject
//
//  Created by Виктория Щербакова on 16.03.2022.
//

import Foundation


struct CellModel {
    var homeTeamName: String
    var awayTeamName: String
    var status: String
    var score: String

    init(match: Match) {
        self.homeTeamName = match.homeTeam?.name ?? ""
        self.awayTeamName = match.awayTeam?.name ?? ""
        self.status = match.status ?? ""

        let homeScore: Int = match.score?.fullTime?.homeTeam ?? 0
        let awayScore: Int = match.score?.fullTime?.awayTeam ?? 0
        self.score = "\(homeScore) : \(awayScore)"
    }
}
