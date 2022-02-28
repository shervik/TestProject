//
//  Matches.swift
//  TestProject
//
//  Created by Виктория Щербакова on 25.02.2022.
//


import Foundation

// MARK: - Matches
struct Matches: Decodable {
    let count: Int?
    let filters: Filters?
    let matches: [Match]?
}

// MARK: - Filters
struct Filters: Decodable {
    let dateFrom, dateTo: String?
}

// MARK: - Match
struct Match: Decodable {
    let id: Int?
    let competition: Competition?
    let season: Season?
    //let utcDate: Date?
    let status: String?
    //let attendance: JSONNull?
    let matchday: Int?
    let stage, group: String?
    //let lastUpdated: Date?
    let homeTeam, awayTeam: Team?
    let score: Score?
    let goals: [Goal]?
    let bookings: [Booking]?
    let substitutions: [Substitution]?
    let referees: [Coach]?
}

// MARK: - Team
struct Team: Decodable {
    let id: Int?
    let name: String?
    let coach: Coach?
    let captain: Captain?
    let lineup, bench: [Captain]?
}

// MARK: - Captain
struct Captain: Decodable {
    let id: Int?
    let name: String?
    let position: String?
    let shirtNumber: Int?
}

// MARK: - Coach
struct Coach: Decodable {
    let id: Int?
    let name: String?
    let countryOfBirth: String?
    let nationality: String?
}

// MARK: - Booking
struct Booking: Decodable {
    let minute: Int?
    let team, player: Competition?
    let card: Card?
}

enum Card: String, Decodable {
    case redCard = "RED_CARD"
    case yellowCard = "YELLOW_CARD"
    case yellowRedCard = "YELLOW_RED_CARD"
}

// MARK: - Competition
struct Competition: Decodable {
    let id: Int?
    let name: String?
}

// MARK: - Goal
struct Goal: Decodable {
    let minute: Int?
    let type: String?
    let team, scorer: Competition?
    let assist: Competition?
}

// MARK: - Score
struct Score: Decodable {
    let winner: String?
    let duration: String?
    let fullTime, halfTime, extraTime, penalties: ExtraTime?
}

// MARK: - ExtraTime
struct ExtraTime: Decodable {
    let homeTeam, awayTeam: Int?
}

// MARK: - Season
struct Season: Decodable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
    let availableStages: [String]?
}

// MARK: - Substitution
struct Substitution: Decodable {
    let minute: Int?
    let team, playerOut, playerIn: Competition?
}
