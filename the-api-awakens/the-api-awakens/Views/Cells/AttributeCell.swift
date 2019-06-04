//
//  AttributeCell.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 25/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class AttributeCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var conversionControl: UISegmentedControl!
    
    // MARK: - Properties
    
    var viewModel: AttributeViewModel? {
        didSet {
            if let viewModel = viewModel {
                // Update cell labels
                nameLabel.text = viewModel.name
                descriptionLabel.text = viewModel.description
                
                // Add Segmented Control if needed
                if viewModel is CurrencyConvertibleAttribute && viewModel.description != "Unknown" {
                    setupConversionControl(with: #selector(currencyChanged))
                } else if viewModel is MeasureConvertibleAttribute && viewModel.description != "Unknown" {
                    setupConversionControl(with: #selector(unitChanged))
                } else {
                    conversionControl.isHidden = true
                }
            }
        }
    }
    
    var showExchangeRateAlert: (() -> Void)?
    
    // MARK: - Cell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    // MARK: - Helpers
    
    func setupConversionControl(with selector: Selector) {
        if let viewModel = viewModel as? Convertible, let labels = viewModel.conversionControlLabels {
            conversionControl.setTitle(labels[0], forSegmentAt: 0)
            conversionControl.setTitle(labels[1], forSegmentAt: 1)
            conversionControl.apportionsSegmentWidthsByContent = true
            conversionControl.addTarget(self, action: selector, for: .valueChanged)
            conversionControl.isHidden = false
            conversionControl.selectedSegmentIndex = 0
        }
    }
    
//    func updateDescriptionLabel(with string: String) {
//        descriptionLabel.text = string
//    }
    
    // MARK: - Actions
    
    @objc func currencyChanged(_ sender: UISegmentedControl) {
        if let viewModel = viewModel as? CurrencyConvertibleAttribute {
            switch sender.selectedSegmentIndex {
            case 0: descriptionLabel.text = viewModel.description
            case 1: showExchangeRateAlert?()
            default: break
            }
        }
    }
    
    @objc func unitChanged(_ sender: UISegmentedControl) {
        if let viewModel = viewModel as? MeasureConvertibleAttribute {
            switch sender.selectedSegmentIndex {
            case 0: descriptionLabel.text = viewModel.description
            case 1: descriptionLabel.text = viewModel.convertedDescription
            default: break
            }
        }
    }
}

