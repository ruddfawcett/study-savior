//
//  CustomField.swift
//  StudySavior
//
//  Created by Ally Klionsky on 5/3/19.
//  Copyright © 2019 Ally Klionsky. All rights reserved.
//

import UIKit

@IBDesignable class CustomField: UITextField {
    
    @IBInspectable var leftPaddng: CGFloat = 10.0
    
    override func drawPlaceholder(in rect: CGRect) {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: leftPaddng, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        super.drawPlaceholder(in: rect)
    }
}
