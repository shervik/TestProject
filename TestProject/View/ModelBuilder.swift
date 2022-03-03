//
//  ModelBuilder.swift
//  TestProject
//
//  Created by Виктория Щербакова on 03.03.2022.
//

import Foundation
import UIKit

protocol Builder {
    static func createModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createModule() -> UIViewController {
        let view = ViewController()
        let networkManager = NetworkManager()
        let date = Date()
        let presenter = MatchesPresenter(view: view, networkManager: networkManager, date: date)
        view.presenter = presenter
        return view
    }
    
    
}
