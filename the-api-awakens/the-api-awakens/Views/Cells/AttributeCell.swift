//
//  AttributeCell.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 25/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit


protocol AttributeCellDelegate: class {
    // present alert to request exchange rate
    // update cell.descriptionLabel with new value of the ViewModel in USD
    func didTapOnCurrencyConverter(cell: AttributeCell, viewModel: CurrencyConvertibleAttribute)
}

class AttributeCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var conversionControl: UISegmentedControl!
    
    var viewModel: AttributeViewModel? {
        didSet {
            if let viewModel = viewModel {
                nameLabel.text = viewModel.name
                descriptionLabel.text = viewModel.description
                
                if let viewModel = viewModel as? Convertible {
                    setupConversionControl(with: viewModel.conversionControlLabels)
                }
            }
        }
    }
    
    weak var delegate: AttributeCellDelegate?
    
    var alertHandler: ((UIAlertAction) -> Void?)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Helpers
    
    func setupConversionControl(with labels: [String]) {
        conversionControl.isHidden = false
        conversionControl.apportionsSegmentWidthsByContent = true
        conversionControl.setTitle(labels[0], forSegmentAt: 0)
        conversionControl.setTitle(labels[1], forSegmentAt: 1)
        conversionControl.selectedSegmentIndex = 0
    }
    
    // MARK: - Actions
    
    @IBAction func unitsChanged(_ sender: UISegmentedControl) {
        if let viewModel = viewModel as? CurrencyConvertibleAttribute {
            // alert controller to get exchange rate
            print("tapped on currency converter")
            delegate?.didTapOnCurrencyConverter(cell: self, viewModel: viewModel)
        } else if let viewModel = viewModel as? MeasurableAttribute {
            switch sender.selectedSegmentIndex {
            case 0: descriptionLabel.text = viewModel.description
            case 1: descriptionLabel.text = viewModel.convertedDescription
            default: break
            }
        }
    }
}

