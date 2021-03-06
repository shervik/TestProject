//
//  TableCell.swift
//  TestProject
//
//  Created by Виктория Щербакова on 25.02.2022.
//

import Foundation
import UIKit

final class TableCell: UICollectionViewCell {
    
    private lazy var homeTeam = { UILabel() }()
    private lazy var awayTeam = { UILabel() }()
    private lazy var scoreMatch = { UILabel() }()
    private lazy var status = { UILabel() }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(homeTeam)
        addSubview(awayTeam)
        addSubview(scoreMatch)
        addSubview(status)

        configureHomeTeam()
        configureAwayTeam()
        configureScore()
        configureStatus()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextCell(match: Match) {
        homeTeam.text = match.homeTeam?.name
        awayTeam.text = match.awayTeam?.name
    }
    
    func setScoreCell(score: Score) {
        let homeScore: Int = score.fullTime?.homeTeam ?? 0
        let awayScore: Int = score.fullTime?.awayTeam ?? 0
        scoreMatch.text = "\(homeScore) : \(awayScore)"
    }
    
    func setStatus(match: Match) {
        status.text = match.status
    }
    
    private func configureHomeTeam() {
        homeTeam.translatesAutoresizingMaskIntoConstraints = false
        homeTeam.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        homeTeam.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        homeTeam.rightAnchor.constraint(equalTo: scoreMatch.leftAnchor, constant: -10).isActive = true
        homeTeam.font = UIFont.systemFont(ofSize: 15)
        homeTeam.textAlignment = .center
    }
    
    private func configureAwayTeam() {
        awayTeam.translatesAutoresizingMaskIntoConstraints = false
        awayTeam.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        awayTeam.leftAnchor.constraint(equalTo: scoreMatch.rightAnchor, constant: 10).isActive = true
        awayTeam.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        awayTeam.font = UIFont.systemFont(ofSize: 15)
        awayTeam.textAlignment = .center
    }
    
    private func configureScore() {
        scoreMatch.translatesAutoresizingMaskIntoConstraints = false
        scoreMatch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        scoreMatch.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scoreMatch.font = UIFont.systemFont(ofSize: 30)
        scoreMatch.textAlignment = .center
    }
    
    private func configureStatus() {
        status.translatesAutoresizingMaskIntoConstraints = false
        status.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        status.topAnchor.constraint(equalTo: topAnchor).isActive = true
        status.bottomAnchor.constraint(equalTo: scoreMatch.topAnchor).isActive = true
        status.font = UIFont.systemFont(ofSize: 10)
        status.textAlignment = .center
        status.textColor = .systemGreen
    }
}
