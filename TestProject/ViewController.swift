//
//  ViewController.swift
//  TestProject
//
//  Created by Виктория Щербакова on 25.02.2022.
//

private enum LayoutConstant {
    static let spacing: CGFloat = 10.0
    static let itemHeight: CGFloat = 100.0
}

import UIKit

final class ViewController: UIViewController {
    private var safeArea: UILayoutGuide { view.safeAreaLayoutGuide }

    private lazy var titleLive: UILabel = { UILabel() }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
    }()
    
    private lazy var segmentControl: UISegmentedControl = { UISegmentedControl(items: menuItems) }()
    
    private let menuItems = ["Вчера", "Сегодня", "Завтра"]
    
    private var viewModel: MatchesViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        setSegmentControl(selectedIndex: 1)
        setTitle(titleText: "Title")
        setTableView()
        viewModel = MatchesViewModel()
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
        self.collectionView.reloadData()
        switch segmentControl.selectedSegmentIndex {
        case 0: viewModel?.fetchMatches(date: Date.yesterday) { self.collectionView.reloadData() }
        case 1: viewModel?.fetchMatches(date: Date.today) { self.collectionView.reloadData() }
        default: viewModel?.fetchMatches(date: Date.tomorrow) { self.collectionView.reloadData() }
        }
    }
    
    private func setTableView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLive.bottomAnchor, constant: 30).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.alwaysBounceVertical = true
        collectionView.register(TableViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TableViewCell
    
        cell.viewModel = viewModel?.cellViewModel(at: indexPath)
        
        cell.layer.borderColor = UIColor.systemGreen.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 30
        return cell
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: safeArea.layoutFrame.width, spacing: 0)
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 1
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return finalWidth - 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }

}
