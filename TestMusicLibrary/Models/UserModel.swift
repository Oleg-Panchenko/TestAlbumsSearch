//
//  UserModel.swift
//  TestMusicLibrary
//
//  Created by Panchenko Oleg on 13.07.2022.
//

import Foundation

struct User: Codable {
    let firstName: String
    let secondName: String
    let phone: String
    let email: String
    let password: String
    let age: Date
}
