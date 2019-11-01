//
//  LaptopDetailViewController.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 01/11/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import UIKit
import PromiseKit

class LaptopDetailViewController: BaseViewController, LaptopDetailContractView {
    
    var presenter: LaptopDetailContractPresenter!
    
    @IBOutlet weak var myNavigationItem: UINavigationItem!
    @IBOutlet weak var laptopImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myNavigationItem.title = Constants.Strings.Detail
        titleLabel.text        = item?.title ?? ""
        descriptionLabel.text  = item?.laptopDescription ?? ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        laptopImage.image = Constants.Images.placeholder
        if let myItem = item {
            self.presenter.getImageFor(myItem).done { imgData in
                self.laptopImage.image = UIImage(data: imgData)
            }.catch { _ in
                self.laptopImage.image = Constants.Images.placeholder
            }
        }
    }
    
    override func injectDependencies() {
        super.injectDependencies()
        presenter = Configurator.getLaptopDetailPresenter(viewController: self)
    }
    
}
