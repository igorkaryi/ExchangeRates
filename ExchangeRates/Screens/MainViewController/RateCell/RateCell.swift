//
//  RateCell.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 10.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import UIKit

class RateCell: UITableViewCell {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var valueLabel: UILabel!
    
    func setModel(_ model: ERRate?) {
        guard let model = model else { return }
        
        titleLabel.text = model.title
        
        let value = model.value.rounded(toPlaces: 2)
        valueLabel.text = "\(value)"
    }

}
