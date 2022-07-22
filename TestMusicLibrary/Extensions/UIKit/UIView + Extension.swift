//
//  UIView + Extension.swift
//  TestMusicLibrary
//
//  Created by Panchenko Oleg on 16.07.2022.
//

import UIKit

extension UIView {
   func pinToSuperview() {
       guard let superview = superview else { return }
       NSLayoutConstraint.activate([
           leadingAnchor.constraint(equalTo: superview.leadingAnchor),
           trailingAnchor.constraint(equalTo: superview.trailingAnchor),
           topAnchor.constraint(equalTo: superview.topAnchor),
           bottomAnchor.constraint(equalTo: superview.bottomAnchor)
       ])
   }
}
