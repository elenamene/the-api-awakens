//
//  ResultsPickerDataSource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 06/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class PickerDataSource: NSObject, UIPickerViewDataSource {
    
    private var resources = [Resource]()
    
    override init() {
        super.init()
    }
    
    func update(with resources: [Resource]) {
        self.resources = resources
    }
    
    // MARK: - Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return resources.count
    }
    
    // MARK: - Helper
    
    func resource(at row: Int) -> Resource {
        return resources[row]
    }
    
    func index(of resource: Resource) -> Int? {
        return resources.firstIndex(where: { $0.name == resource.name }) ?? nil
    }
}
