//
//  UnderlineLabel.swift
//  VaxGuideSG
//
//  Created by owrmac on 29/7/21.
//

import UIKit

class UnderlinedLabel: UILabel {

override var text: String? {
    didSet {
        guard let text = text else { return }
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        // Add other attributes if needed
        self.attributedText = attributedText
        }
    }
}
