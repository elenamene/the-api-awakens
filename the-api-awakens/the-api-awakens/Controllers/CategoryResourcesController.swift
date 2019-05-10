//
//  CategoryResourcesController.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class CategoryResourcesController: UITableViewController {
    
    var category: Category? {
        didSet {
            if let category = category {
                self.title = category.name
                pickerDataSource.update(with: category.stubData)
                picker.selectRow(0, inComponent: 0, animated: true)
            }
        }
    }
    
    lazy var selectedResource: Resource = {
        let selectedRow = picker.selectedRow(inComponent: 0)
        return pickerDataSource.resource(at: selectedRow)
    }()
    
    var dataSource = ResourceDetailDataSource()
    let picker = UIPickerView()
    var pickerDataSource = ResultsPickerDataSource()
    
    @IBOutlet weak var resourceNameTextField: UITextField!
    @IBOutlet weak var categoryIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryIcon.image = category?.iconImage
        tableView.dataSource = dataSource
        dataSource.update(with: selectedResource)
        
        // Picker
        resourceNameTextField.inputView = picker
        resourceNameTextField.layer.cornerRadius = 8
        picker.dataSource = pickerDataSource
        picker.delegate = self
        
        // TextField
        resourceNameTextField.text = selectedResource.name
    }
}

// MARK: - Picker Delegate

extension CategoryResourcesController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource.resource(at: row).name
    }
    
    // Update textfield and tableView text with row selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let resourceSelected = pickerDataSource.resource(at: row)
        resourceNameTextField.text = resourceSelected.name
        dataSource.update(with: resourceSelected)
        tableView.reloadData()
        self.view.endEditing(true)
    }
}

// MARK: - TextField Delegate

extension ResourceDetailDataSource: UITextFieldDelegate {
    
}
