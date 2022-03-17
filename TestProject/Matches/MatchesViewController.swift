//
//  ViewController.swift
//  TestProject
//
//  Created by Виктория Щербакова on 25.02.2022.
//

import UIKit

protocol MatchesViewInputProtocol: AnyObject {
    func reloadDataForSection(for section: MatchesSectionViewModel)
}

protocol MatchesViewOutputProtocol: AnyObject {
    var menuItems: [DateSegment] { get }
    init(view: MatchesViewInputProtocol)
    func viewDidLoad(date: Date)
}

final class MatchesViewController: UIViewController {
    private static let itemHeight: CGFloat = 100.0
    private static let initialIndex = 1
    private var safeArea: UILayoutGuide { view.safeAreaLayoutGuide }
    
    var presenter: MatchesViewOutputProtocol?
    private let configurator: MatchesConfiguratorInputProtocol = MatchesConfigurator()
    
    private lazy var titleLive: UILabel = { UILabel() }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: UITableView.Style.plain)
        table.separatorStyle = .none
        table.allowsSelection = false
        return table
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let items = menuItems.map { $0.title }
        return UISegmentedControl(items: items)
    }()
    
    private var menuItems: [DateSegment] { presenter?.menuItems ?? [] }
    private var section: SectionRowPresentable = MatchesSectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        updateData(for: MatchesViewController.initialIndex)
        view.backgroundColor = .systemGreen
        setSegmentControl(selectedIndex: MatchesViewController.initialIndex)
        setTitle(titleText: "Title")
        setTableView()
    }
    
    private func setTitle(titleText: String) {
        view.addSubview(titleLive)
        titleLive.text = titleText
        titleLive.translatesAutoresizingMaskIntoConstraints = false
        titleLive.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 30).isActive = true
        titleLive.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        titleLive.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        titleLive.textAlignment = .left
        titleLive.font = UIFont.systemFont(ofSize: 20)
    }
    
    
    private func setSegmentControl(selectedIndex: Int) {
        view.addSubview(segmentControl)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        segmentControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        segmentControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        segmentControl.selectedSegmentIndex = selectedIndex
        
        segmentControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
    }
    
    private func updateData(for segmentIndex: Int) {
        if menuItems.count >= 0 && menuItems.count > segmentIndex {
            presenter?.viewDidLoad(date: menuItems[segmentIndex].date)
        }
    }
    
    @objc private func handleSegmentChange() {
        updateData(for: segmentControl.selectedSegmentIndex)
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLive.bottomAnchor, constant: 30).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.alwaysBounceVertical = true
        tableView.register(TableCell.self, forCellReuseIdentifier: "matchesCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension MatchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.section.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = section.rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier, for: indexPath) as? TableCell else {
            fatalError("Failed to get cell from the tableView. Expected type `TableCell`")
        }
        cell.cellViewModel = cellViewModel
        
        return cell
    }
    
}

extension MatchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MatchesViewController.itemHeight
    }
}

extension MatchesViewController: MatchesViewInputProtocol {
    func reloadDataForSection(for section: MatchesSectionViewModel) {
        self.section = section
        tableView.reloadData()
    }
    
}
