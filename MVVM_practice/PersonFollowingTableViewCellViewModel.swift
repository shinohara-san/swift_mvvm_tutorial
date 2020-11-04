//
//  PersonFollowingTableViewCellViewModel.swift
//  MVVM_practice
//
//  Created by Yuki Shinohara on 2020/11/04.
//

import UIKit

//Modelは全ての要素を持っているが、それを表示する際に全ての要素を使わない。それをViewModelで扱う。

struct PersonFollowingTableViewCellViewModel {
    //Personは他にもaddressやgenderなどあるけど、このtableCellでは使わない
    let name: String
    let username: String
    var currentlyFollowing: Bool
    let image: UIImage?
    
    //Person型のmodelを使ってこのViewModelを作る
    init(with model: Person) {
        name = model.name
        username = model.username
        currentlyFollowing = false
        image = UIImage(systemName: "person")
    }
}
