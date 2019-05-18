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
    
    lazy var dataSource = ResourceDetailDataSource(resource: selectedResource)
    
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
        
        // Dismiss Picker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapGesture(recognizer:)))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - Dismiss Picker
    
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
    // TODO: Disable copy and paste in textField ???
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.dropShadow(color: .white)
        iconButton.isSelected = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.dropShadow(color: .clear, opacity: 0, radius: 0)
        iconButton.isSelected = false
    }
}
