//
//  LaptopCell.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 01/11/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class LaptopCell: UITableViewCell {
    
    @IBOutlet weak var laptopImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var laptopDescription: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    func configureCell(item: Item) {
        title.text = item.title
        laptopDescription.text = item.laptopDescription
        self.laptopImage.image = Constants.Images.placeholder
        
        Alamofire.request(item.imgUrlString ?? "").responseImage { response in
            if let image = response.result.value {
                self.laptopImage.image = image
            } else {
                self.laptopImage.image = Constants.Images.placeholder
            }
        }
    }
}
