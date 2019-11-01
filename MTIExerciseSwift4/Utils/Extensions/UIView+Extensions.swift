//
//  UIView+Extensions.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 31/10/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import UIKit

extension UIView {
    
    // add another view keeping resizing mask sizes
    func add(to view: UIView) {
        view.addSubview(self)
        
        frame = view.bounds
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
