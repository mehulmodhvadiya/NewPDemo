//
//  ArticleCell.swift
//  NewPDemo
//
//  Created by mehul modhvadiya on 17/08/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    // iboutlet connection

    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var imgArticle:UIImageView!
    @IBOutlet weak var imgHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var imgWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var vwHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var vwWidthConstraint:NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
