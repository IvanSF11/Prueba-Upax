//
//  ChartsTableViewControllerRouter.swift
//  Prueba Upax
//
//  Created Ivan Soriano on 31/05/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ChartsTableViewControllerRouter: ChartsTableViewControllerWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ChartsTableViewControllerViewController(nibName: nil, bundle: nil)
        let interactor = ChartsTableViewControllerInteractor()
        let router = ChartsTableViewControllerRouter()
        let presenter = ChartsTableViewControllerPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}