//
//  ViewController.swift
//  TestProject
//
//  Created by Виктория Щербакова on 25.02.2022.
//

import UIKit

enum LayoutConstant {
    static let spacing: CGFloat = 10.0
    static let itemHeight: CGFloat = 100.0
}

final class ViewController: UIViewController {
    private var safeArea: UILayoutGuide { view.safeAreaLayoutGuide }

    private lazy var titleLive: UILabel = { UILabel() }()
    
    private lazy var tableView: UITableView = { UITableView(frame: .zero, style: UITableView.Style.grouped) }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let items = menuItems.map { $0.title }
        return UISegmentedControl(items: items)
    }()
    
    private let menuItems = [
        DateSegment(title: "Вчера", date: .yesterday),
        DateSegment(title: "Сегодня", date: .today),
        DateSegment(title: "Завтра", date: .tomorrow)
    ]
    
    private var dataMatch: [Match] = []
    private let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        let initialIndex = 1
        setSegmentControl(selectedIndex: initialIndex)
        fetchData(for: initialIndex)
        setTitle(titleText: "Title")
        setTableView()
    }
    
    private func getMatches(date: Date) {
        networkManager.getMatches(date: date) { [weak self] (result) in
            switch result {
            case .success(matches: let matches):
                self?.dataMatch = matches
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(String(describing: error))")
            }
        }
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
    
    @objc private func handleSegmentChange() {
        fetchData(for: segmentControl.selectedSegmentIndex)
    }
    
    private func fetchData(for segmentIndex: Int) {
        if menuItems.count >= 0 && menuItems.count > segmentIndex {
            getMatches(date: menuItems[segmentIndex].date)
        }
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLive.bottomAnchor, constant: 30).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.alwaysBounceVertical = true
        tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataMatch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as? TableCell else {
            fatalError("Failed to get cell from the tableView. Expected type `TableCell`")
        }
    
        cell.setText(match: dataMatch[indexPath.row])
        
        cell.layer.borderColor = UIColor.systemGreen.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 30
        cell.clipsToBounds = true
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        LayoutConstant.itemHeight
    }

}
