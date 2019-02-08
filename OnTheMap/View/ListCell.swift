//
//  ListCell.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 31/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var studentLabel: UILabel!
    @IBOutlet private weak var mediaURLLabel: UILabel!

    // MARK: - Configuration
    func configure(with studentLocation: StudentInformation?) {
        guard let fullName = studentLocation?.fullName else {
            return
        }
        guard let mediaUrl = studentLocation?.mediaURL else {
            return
        }
        if fullName.isEmpty { studentLabel.isHidden = true }
        if mediaUrl.isEmpty { mediaURLLabel.isHidden = true }
        studentLabel.text = fullName
        mediaURLLabel.text = mediaUrl
    }
}
