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
    
    lazy var selectedResource: Resource = pickerDataSource.resource(at: 0)
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = pickerDataSource
        
        return pickerView
    }()
    
    lazy var attributesDataSource = AttributesDataSource(from: selectedResource, tableView: self.tableView)
    
    var smallestResource: Resource?
    var largestResource: Resource?
    
    // MARK: - Outlets
    
    @IBOutlet weak var resourceNameTextField: UITextField!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var smallestResourceLabel: UILabel!
    @IBOutlet weak var largestResourceLable: UILabel!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largetLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        iconButton.setImage(category?.iconImage, for: .normal)
        
        // Table View
        tableView.dataSource = attributesDataSource
        attributesDataSource.update(with: selectedResource)
        
        // Smallest and Largest Labels
        smallestResourceLabel.text = smallestResource?.name
        largestResourceLable.text = largestResource?.name
        
        if category == .films {
            smallestLabel.text = "Oldest:"
            largetLabel.text = "Newest:"
        } else {
            smallestLabel.text = "Smallest:"
            largetLabel.text = "Largest:"
        }
        
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Add alert for currency convertion if cell is CurrencyConvertibleAttribute
        if let cell = cell as? AttributeCell, let viewModel = cell.viewModel as? CurrencyConvertibleAttribute { 
            cell.showExchangeRateAlert = { [unowned self] in
                self.showAlertWithTextInput(title: "Enter Exchange Rate", message: "Please enter what you think is the exchange rate between Galactic Credits and US Dollars", inputPlaceholder: "0.62", inputKeyboardType: .numbersAndPunctuation, actionTitle: "Convert", cancelTitle: "Cancel", cancelHandler: { (UIAlertAction) in
                    cell.conversionControl.selectedSegmentIndex = 0
                }, actionHandler: { (text) in
                    if let text = text, let exchangeRate = Double(text), exchangeRate > 0 {
                        cell.descriptionLabel.text = viewModel.convertValue(with: exchangeRate)
                    } else {
                        self.showAlert(title: "Invalid Exchange Rate", message: "Exchange rate needs to be a number grater than 0.")
                        cell.conversionControl.selectedSegmentIndex = 0
                    }
                })
            }
        }
    }
}

// MARK: - Picker Delegate

extension ResourceDetailController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource.resource(at: row).name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedResource = pickerDataSource.resource(at: row)
        resourceNameTextField.text = selectedResource.name
        
        // Update tableView text with row selected
        attributesDataSource.update(with: selectedResource)
        tableView.reloadData()
    }
}

// MARK: - TextField Delegate

extension ResourceDetailController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.dropShadow(color: .white)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.dropShadow(color: .clear, opacity: 0, radius: 0)
    }
}
