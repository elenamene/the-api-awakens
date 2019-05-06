//
//  CategoryResultsController.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class CategoryResultsController: UITableViewController {
    
    var category: Category!
    var dataSource = CategoryResultsDataSource(resources: Stub.characters)
    let picker = UIPickerView()
    var pickerDataSource = ResultsPickerDataSource()
    
    @IBOutlet weak var resultsPickerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View
        self.title = category.name
        tableView.dataSource = dataSource
        
        // Picker
        resultsPickerTextField.inputView = picker
        picker.dataSource = pickerDataSource
        picker.delegate = self
    }
}

// MARK: - Picker Delegate

extension CategoryResultsController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource.resource(at: row).name
    }
    
    // Update textfield text with row selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let resourceSelected = pickerDataSource.resource(at: row)
        resultsPickerTextField.text = resourceSelected.name
    }
}

// MARK: - TextField Delegate

extension CategoryResultsDataSource: UITextFieldDelegate {
    
}
