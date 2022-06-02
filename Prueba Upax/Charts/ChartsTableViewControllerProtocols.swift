//
//  ChartsTableViewControllerProtocols.swift
//  Prueba Upax
//
//  Created Ivan Soriano on 31/05/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ChartsTableViewControllerWireframeProtocol: class {
    
}
//MARK: Presenter -
protocol ChartsTableViewControllerPresenterProtocol: class {
    func callService()
}

//MARK: Interactor -
protocol ChartsTableViewControllerInteractorProtocol: class {
    
    var presenter: ChartsTableViewControllerPresenterProtocol?  { get set }
    func callService(_ callback: @escaping (ResponseData) -> Void)
}

//MARK: View -
protocol ChartsTableViewControllerViewProtocol: class {
    
    var presenter: ChartsTableViewControllerPresenterProtocol?  { get set }
    func set(data: ResponseData)
}
