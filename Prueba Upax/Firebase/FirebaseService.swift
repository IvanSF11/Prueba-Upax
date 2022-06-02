//
//  FirebaseService.swift
//  Prueba Upax
//
//  Created by Ivan Soriano on 31/05/22.
//
import UIKit
import Firebase
import FirebaseStorage

final class FirebaseService {
    private var database: DatabaseReference?
    private var storage = Storage.storage().reference()
    
    weak var tableView: MainTableViewController!
    
    func retrieveBackgroundColor() {
        database = Database.database().reference()
        database?.observe(DataEventType.value) { [weak self] snapshot in
            if let color = snapshot.childSnapshot(forPath: "background").value as? String {
                print("Firebase Real Time DB background update", color)
                let uiColor = UIColor(hex: color)
                self?.tableView.view.backgroundColor = uiColor
                self?.tableView.tableView.backgroundColor = uiColor
            }
        }
    }
    
    func uploadSelfie(with name: String?, using selfie: UIImage?) {
        guard let name = name, let selfie = selfie, let data = selfie.jpegData(compressionQuality: 0.5) else {
            showErrorAlert()
            return
        }
        
        let selfieRef = storage.child("Fotos/\(name)-\(UUID().uuidString).jpg")
        let metadata = StorageMetadata(dictionary: ["user": name, "timestamp": Date()])
        let uploadTask = selfieRef.putData(data, metadata: metadata) { [weak self] _, error in
            if let error = error {
                debugLog("Error to upload the image", in: .networking, with: error)
                return
            }
            DispatchQueue.main.async {
                self?.showSuccessAlert()
            }
        }
        uploadTask.resume()
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Aviso", message: "Por favor escriba un nombre y tome una foto.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(okButton)
        tableView.present(alert, animated: true)
    }
    
    private func showSuccessAlert() {
        let alert = UIAlertController(title: "¡Éxito!", message: "La selfie se subió correctamente.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(okButton)
        tableView.present(alert, animated: true)
    }
}
