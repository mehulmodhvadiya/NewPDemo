//
//  ArticleDetailVC.swift
//  NewPDemo
//
//  Created by mehul modhvadiya on 17/08/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleDetailVC: UIViewController {

    // Mark: iboutlet connection
    
    @IBOutlet var lblselftext:UILabel!
    @IBOutlet var lblAuther:UILabel!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var imgDetail:UIImageView!
    @IBOutlet weak var imgHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var imgWidthConstraint:NSLayoutConstraint!

    var arrArticleList = [articleChildren]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mark: navigation title
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = arrArticleList[0].data.title

        // Mark: show the article data
        
        lblTitle.text = arrArticleList[0].data.title
        lblAuther.text = arrArticleList[0].data.author_fullname
        lblselftext.text = arrArticleList[0].data.selftext
        
        if arrArticleList[0].data.thumbnail == "self" {
                    imgWidthConstraint.constant = 0
                    imgHeightConstraint.constant = 0
                    imgDetail.isHidden = true
                    
                }else {
                    imgWidthConstraint.constant = 394
                    imgHeightConstraint.constant = 150
                    imgDetail.isHidden = false
                    imgDetail.sd_setImage(with: URL(string: arrArticleList[0].data.thumbnail), placeholderImage: UIImage(named: "placeholder.png"))
                }

    }
}
