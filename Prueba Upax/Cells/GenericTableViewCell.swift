//
//  GenericTableViewCell.swift
//  Prueba Upax
//
//  Created by Ivan Soriano on 31/05/22.
//

import UIKit

class GenericTableViewCell: UITableViewCell {
    
    static let identifier = "GenericTableViewCell"
    
    var mainTableViewController: MainTableViewController!
    
    lazy var textfield: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .alphabet
        textField.textContentType = .name
        textField.placeholder = "Escribe tu nombre"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCells(type: cellType){
        switch type {
        case .Name:
            break
        case .Photo:
            label.text = "Toma una foto"
        case .Graphic:
            label.text = "Ver las gráficas"
        case .UploadPhoto:
            label.text = "Subir foto a la nube"
        }
        setCell()
        setConstraints(type: type)
    }
    
    func setCell(){
        layer.backgroundColor = UIColor.clear.cgColor
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func setConstraints(type: cellType){
        let margins = contentView.layoutMarginsGuide
        let padding: CGFloat = 15.0
        let view = type == .Name ? textfield : label
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: padding),
            view.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: padding),
            view.firstBaselineAnchor.constraint(equalTo: margins.topAnchor, constant: padding * 1.75),
            margins.bottomAnchor.constraint(equalTo: view.lastBaselineAnchor, constant: padding)
        ])
    }
    
    func userTookPicture() {
        label.text = "Selfie tomado"
    }
}


extension GenericTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        var allowedCharacters = CharacterSet.letters
        allowedCharacters.insert(" ")
        return string.rangeOfCharacter(from: allowedCharacters) != nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
}
