//
//  AlertOk.swift
//  TestMusicLibrary
//
//  Created by Panchenko Oleg on 13.07.2022.
//

import UIKit

extension UIViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
