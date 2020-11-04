//
//  Models.swift
//  MVVM_practice
//
//  Created by Yuki Shinohara on 2020/11/04.
//

import Foundation

enum Gender {
    case male, female, unspecified
}

struct Person {
    let name: String
    let birthDate: Date?
    let middleName: String?
    let gender: Gender
    let address: String?
    
    var username = "username" //ホントはちゃんとinitで値を得る
    
    init(name: String, birthDate: Date? = nil, middleName:String? = nil, gender:Gender = .unspecified, address:String? = nil) {
        self.name = name
        self.birthDate = birthDate
        self.middleName = middleName
        self.gender = gender
        self.address = address
    }
}
