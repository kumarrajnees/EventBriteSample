//
//  EventTableViewCell.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class EventTableViewCell: UITableViewCell, Identifiable {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imageBaseView: UIView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    var eventData: JSON? {
        didSet {
            updateUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowToBaseView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    fileprivate func addShadowToBaseView() {
        baseView.layer.cornerRadius = 10
        baseView.clipsToBounds = true
        baseView.layer.borderColor = UIColor.gray.cgColor
        baseView.layer.borderWidth = 1
    }
    fileprivate func updateUI(){
        titleLable.text = eventData?["name"]["text"].stringValue
        descLabel.text = eventData?["description"]["text"].stringValue
        if  let imageURL = eventData?["logo"]["url"].stringValue, let url = URL.init(string: imageURL) {
            eventImageView.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions.refreshCached, context: nil)
        }
        eventDateLabel.text = eventData?["venue"]["address"]["localized_address_display"].stringValue
    }
    
}
