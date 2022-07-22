//
//  RequiredValidLabel.swift
//  TestMusicLibrary
//
//  Created by Panchenko Oleg on 19.07.2022.
//

import UIKit

class RequiredValidLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.font = UIFont.systemFont(ofSize: 14)
        let text = "*Required field"
        let range = (text as NSString).range(of: "*")
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(.foregroundColor, value: UIColor.red , range: range)
        attributedText = attributedString
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
