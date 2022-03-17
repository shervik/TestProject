//
//  ViewController.swift
//  TestProject
//
//  Created by Виктория Щербакова on 25.02.2022.
//

import UIKit

final class ViewController: UIViewController {
    private static let itemHeight: CGFloat = 100.0
    private static let initialIndex = 1
    
    private var safeArea: UILayoutGuide { view.safeAreaLayoutGuide }

    private lazy var titleLive: UILabel = { UILabel() }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: UITableView.Style.plain)
        table.separatorStyle = .none
        table.allowsSelection = false
        return table
    }()
    
    private var viewModel: MatchesViewModelProtocol?
    
    private var menuItems: [DateSegment] { viewModel?.menuItems ?? [] }

    private lazy var segmentControl: UISegmentedControl = {
        let items = menuItems.map { $0.title }
        return UISegmentedControl(items: items)
    }()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        viewModel = MatchesViewModel()
        setSegmentControl(selectedIndex: ViewController.initialIndex)
        updateData(for: ViewController.initialIndex)
        setTitle(titleText: viewModel?.title ?? "")
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
            viewModel?.viewChangedData(date: menuItems[segmentIndex].date) { self.tableView.reloadData() }
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
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            fatalError("Failed to get cell from the tableView. Expected type `TableViewCell`")
        }
        
        cell.viewModel = viewModel?.cellViewModel(at: indexPath)
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ViewController.itemHeight
    }
}
