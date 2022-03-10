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
    
    private lazy var homeTeam = { UILabel() }()
    private lazy var awayTeam = { UILabel() }()
    private lazy var scoreMatch = { UILabel() }()
    private lazy var status = { UILabel() }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(homeTeam)
        contentView.addSubview(awayTeam)
        contentView.addSubview(scoreMatch)
        contentView.addSubview(status)
        
        configureHomeTeam()
        configureAwayTeam()
        configureScore()
        configureStatus()
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += LayoutConstant.spacing
            frame.size.width -= 2 * LayoutConstant.spacing
            frame.size.height -= 2 * LayoutConstant.spacing
            super.frame = frame
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        homeTeam.text = nil
        awayTeam.text = nil
        scoreMatch.text = nil
        status.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(match: Match) {
        homeTeam.text = match.homeTeam?.name
        awayTeam.text = match.awayTeam?.name
        status.text = match.status
        
        let homeScore: Int = match.score?.fullTime?.homeTeam ?? 0
        let awayScore: Int = match.score?.fullTime?.awayTeam ?? 0
        scoreMatch.text = "\(homeScore) : \(awayScore)"
    }
    
    private func configureHomeTeam() {
        homeTeam.translatesAutoresizingMaskIntoConstraints = false
        homeTeam.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        homeTeam.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        homeTeam.rightAnchor.constraint(equalTo: scoreMatch.leftAnchor, constant: -10).isActive = true
        homeTeam.font = UIFont.systemFont(ofSize: 15)
        homeTeam.numberOfLines = 0
        homeTeam.textAlignment = .center

    }
    
    private func configureAwayTeam() {
        awayTeam.translatesAutoresizingMaskIntoConstraints = false
        awayTeam.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        awayTeam.leftAnchor.constraint(equalTo: scoreMatch.rightAnchor, constant: 10).isActive = true
        awayTeam.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        awayTeam.font = UIFont.systemFont(ofSize: 15)
        awayTeam.numberOfLines = 0
        awayTeam.textAlignment = .center
    }
    
    private func configureScore() {
        scoreMatch.translatesAutoresizingMaskIntoConstraints = false
        scoreMatch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        scoreMatch.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        scoreMatch.font = UIFont.systemFont(ofSize: 30)
        scoreMatch.setContentCompressionResistancePriority(.required, for: .horizontal)
        scoreMatch.textAlignment = .center
    }
    
    private func configureStatus() {
        status.translatesAutoresizingMaskIntoConstraints = false
        status.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        status.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        status.bottomAnchor.constraint(equalTo: scoreMatch.topAnchor).isActive = true
        status.font = UIFont.systemFont(ofSize: 10)
        status.textAlignment = .center
        status.textColor = .systemGreen
    }
}
