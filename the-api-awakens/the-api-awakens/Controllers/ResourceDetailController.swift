//
//  CategoryResourcesController.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class ResourceDetailController: UITableViewController {
    
    // MARK: - Properties
    
    var pickerDataSource = PickerDataSource()
    
    var category: Category? {
        didSet {
            if let category = category {
                self.title = category.name
            }
        }
    }
    
    var categoryResources: [Resource]? {
        didSet {
            if let categoryResources = categoryResources {
                pickerDataSource.update(with: categoryResources)
            }
        }
    }
    
    var selectedResource: Resource {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        return pickerDataSource.resource(at: selectedRow)
    }
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        pickerView.dataSource = pickerDataSource
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        return pickerView
    }()
    
    lazy var dataSource = AttributesDataSource(from: selectedResource)
    
    // MARK: - Outlets
    
    @IBOutlet weak var resourceNameTextField: UITextField!
    @IBOutlet weak var iconButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        iconButton.setImage(category?.iconImage, for: .normal)
        
        // Table View
        tableView.dataSource = dataSource
        dataSource.update(with: selectedResource)
        
        // Name Text Field
        resourceNameTextField.inputView = pickerView
        resourceNameTextField.text = selectedResource.name
        
        // Tap Gesture to Dismiss Picker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapGesture(recognizer:)))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - Gesture
    
    // Dismiss date picker when tapping outside the view
    @objc func backgroundTapGesture(recognizer: UITapGestureRecognizer) {
        pickerView.resignFirstResponder()
        iconButton.isSelected = false
        self.view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction func selectResource(_ sender: RoundButton) {
        resourceNameTextField.becomeFirstResponder()
        sender.isSelected = true
    }
}

// MARK: - TableView Delegate

extension ResourceDetailController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? AttributeCell {
            cell.delegate = self
        }
    }
}

// MARK: - Picker Delegate

extension ResourceDetailController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource.resource(at: row).name
    }
    
    // Update nameLabel and tableView text with row selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        resourceNameTextField.text = selectedResource.name
        dataSource.update(with: selectedResource)
        tableView.reloadData()
        iconButton.isSelected = false
    }
}

// MARK: - TextField Delegate

extension ResourceDetailController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.dropShadow(color: .white)
        iconButton.isSelected = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.dropShadow(color: .clear, opacity: 0, radius: 0)
        iconButton.isSelected = false
    }
}

// MARK: - AttributeCell Delegate

extension ResourceDetailController: AttributeCellDelegate {
    func didTapOnCurrencyConverter(cell: AttributeCell, viewModel: CurrencyConvertibleAttribute) {
        print("AttributeCellDelegate called")
        let alert = UIAlertController(title: "Enter Exchange Rate", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "0.62"
            textField.keyboardType = .numbersAndPunctuation
        }
        
        let convertAction = UIAlertAction(title: "Convert", style: .default) { [weak alert] (_)  in
            if let exchangeRate = alert?.textFields?.first?.text, let exchangeRateNumber = Double(exchangeRate), exchangeRateNumber > 0 {
                print("Exchange rate: \(exchangeRate)")
                // change cell description text
                if let viewModel = cell.viewModel as? CurrencyConvertibleAttribute {
                    cell.descriptionLabel.text = viewModel.convertedValue(with: exchangeRateNumber)
                }
                
                self.dismiss(animated: true, completion: nil)
            } else {
                alert?.message = "Please enter a valid number."
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(convertAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

}
