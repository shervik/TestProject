//
//  TableCell.swift
//  TestProject
//
//  Created by Виктория Щербакова on 25.02.2022.
//

import Foundation
import UIKit

final class TableCell: UITableViewCell {
    static let identifier = "MatchesCell"
    private static let spacing: CGFloat = 10.0

    private lazy var homeTeam = { UILabel() }()
    private lazy var awayTeam = { UILabel() }()
    private lazy var scoreMatch = { UILabel() }()
    private lazy var status = { UILabel() }()
    private lazy var content = { UIView() }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        content.layer.borderColor = UIColor.systemGreen.cgColor
        content.layer.borderWidth = 2
        content.layer.cornerRadius = 30
        content.clipsToBounds = true
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubview(content)
        
        content.addSubview(homeTeam)
        content.addSubview(awayTeam)
        content.addSubview(scoreMatch)
        content.addSubview(status)
        
        setupContent()
        configureHomeTeam()
        configureAwayTeam()
        configureScore()
        configureStatus()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        homeTeam.text = nil
        awayTeam.text = nil
        scoreMatch.text = nil
        status.text = nil
    }
    
    func setText(cellModel: CellModel) {
        homeTeam.text = cellModel.homeTeamName
        awayTeam.text = cellModel.awayTeamName
        status.text = cellModel.status
        scoreMatch.text = cellModel.score
    }
    
//    func setText(match: Match) {
//        homeTeam.text = match.homeTeam?.name ?? ""
//        awayTeam.text = match.awayTeam?.name ?? ""
//        status.text = match.status ?? ""
//
//        let homeScore: Int = match.score?.fullTime?.homeTeam ?? 0
//        let awayScore: Int = match.score?.fullTime?.awayTeam ?? 0
//        scoreMatch.text = "\(homeScore) : \(awayScore)"
//    }
    
    private func setupContent() {
        content.translatesAutoresizingMaskIntoConstraints = false
        content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: TableCell.spacing).isActive = true
        content.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: TableCell.spacing).isActive = true
        content.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -TableCell.spacing).isActive = true
        content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -TableCell.spacing).isActive = true
    }
    
    private func configureHomeTeam() {
        homeTeam.translatesAutoresizingMaskIntoConstraints = false
        homeTeam.centerYAnchor.constraint(equalTo: content.centerYAnchor).isActive = true
        homeTeam.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 10).isActive = true
        homeTeam.rightAnchor.constraint(equalTo: scoreMatch.leftAnchor, constant: -10).isActive = true
        homeTeam.font = UIFont.systemFont(ofSize: 15)
        homeTeam.numberOfLines = 0
        homeTeam.textAlignment = .center
    }
    
    private func configureAwayTeam() {
        awayTeam.translatesAutoresizingMaskIntoConstraints = false
        awayTeam.centerYAnchor.constraint(equalTo: content.centerYAnchor).isActive = true
        awayTeam.leftAnchor.constraint(equalTo: scoreMatch.rightAnchor, constant: 10).isActive = true
        awayTeam.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -10).isActive = true
        awayTeam.font = UIFont.systemFont(ofSize: 15)
        awayTeam.numberOfLines = 0
        awayTeam.textAlignment = .center
    }
    
    private func configureScore() {
        scoreMatch.translatesAutoresizingMaskIntoConstraints = false
        scoreMatch.centerYAnchor.constraint(equalTo: content.centerYAnchor).isActive = true
        scoreMatch.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
        scoreMatch.font = UIFont.systemFont(ofSize: 30)
        scoreMatch.setContentCompressionResistancePriority(.required, for: .horizontal)
        scoreMatch.textAlignment = .center
    }
    
    private func configureStatus() {
        status.translatesAutoresizingMaskIntoConstraints = false
        status.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
        status.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        status.bottomAnchor.constraint(equalTo: scoreMatch.topAnchor).isActive = true
        status.font = UIFont.systemFont(ofSize: 10)
        status.textAlignment = .center
        status.textColor = .systemGreen
    }
}
