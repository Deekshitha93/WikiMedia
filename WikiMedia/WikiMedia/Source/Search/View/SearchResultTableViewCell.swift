//
//  SearchResultTableViewCell.swift
//  WikiMedia
//
//  Created by Deekshitha on 30/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var thumnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var placeHolderImage: UIImage? {
        return UIImage(named: ImageNameConstant.placeHolder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumnailImageView.image = placeHolderImage
    }
    
    func configure(name: String?, description: String?, thumbnailString: String?) {
        nameLabel.text = name
        descriptionLabel.text = description
        
        if let thumbnailUrl = thumbnailString, let imageUrl = URL.init(string: thumbnailUrl) {
            thumnailImageView.af_setImage(withURL: imageUrl, placeholderImage: placeHolderImage)
        }
    }
}
