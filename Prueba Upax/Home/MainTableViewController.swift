//
//  MainTableViewController.swift
//  Prueba Upax
//
//  Created Ivan Soriano on 31/05/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MainTableViewController: UIViewController, MainTableViewProtocol {
    
    var presenter: MainTablePresenterProtocol?
    
    private var firebase = FirebaseService()
    
    lazy var generiCell = GenericTableViewCell()
    
    private var photo: UIImage?
    private var name: String? { generiCell.textfield.text }
    
    let tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setUpTable()
        firebase.retrieveBackgroundColor()
    }
    
    func setView(){
        navigationItem.title = "Upax"
        navigationController?.navigationBar.prefersLargeTitles = true
        generiCell.mainTableViewController = self
    }
    
    func setUpTable(){
        tableView.register(GenericTableViewCell.self, forCellReuseIdentifier: GenericTableViewCell.identifier)
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
        tableView.delegate = self
        tableView.dataSource = self
        firebase.tableView = self
    }
    
    func setConstraints(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func openCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.delegate = self
        cameraController.cameraDevice = .front
        self.present(cameraController, animated: true)
    }
    
    private func errorCameraAlert() {
        let alert = UIAlertController(title: "Aviso", message: "No se puede abrir la camara en un simulador, cambia a un dispositivo.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension MainTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.identifier, for: indexPath) as! GenericTableViewCell
        switch indexPath.row {
        case 0:
            cell.setUpCells(type: .Name)
        case 1:
            cell.setUpCells(type: .Photo)
        case 2:
            cell.setUpCells(type: .Graphic)
        case 3:
            cell.setUpCells(type: .UploadPhoto)
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            #if targetEnvironment(simulator)
            errorCameraAlert()
            #else
            openCamera()
            #endif
        case 2:
            let vc = ChartsTableViewControllerRouter.createModule()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            firebase.uploadSelfie(with: name, using: photo)
        default:
            return
        }
    }
}

extension MainTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            photo = uiImage
            generiCell.userTookPicture()
        }
        dismiss(animated: true)
    }
}
