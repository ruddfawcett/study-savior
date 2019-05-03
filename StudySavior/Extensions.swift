//
//  Extensions.swift
//  StudySavior
//
//  Created by Ally Klionsky on 5/2/19.
//  Copyright © 2019 Ally Klionsky. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UISearchController {
    var hairlineView: UIView? {
        guard let barBackgroundView = self.searchBar.superview?.subviews.filter({ String(describing: type(of: $0)) == "_UIBarBackground" }).first
            else { return nil }
        
        return barBackgroundView.subviews.filter({ $0.bounds.height == 1 / self.traitCollection.displayScale }).first
    }
}

extension UITableViewCell {
    func removeTopSectionSeparator() {
        if subviews.count > 3 {
            subviews[3].removeFromSuperview()
        }
    }
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
