//
//  Constants.swift
//  BestSeller
//
//  Created by erick manrique on 1/10/18.
//  Copyright © 2018 erick manrique. All rights reserved.
//

import UIKit

// MARK:- Colors

let appBaseColor: UIColor = .red
let navigationBarTintColor: UIColor = .white
let navigationBarTitleTextColor: UIColor = .white

// MARK:-  UserDefault keys
let filterKey: String = "filterKey"

// MARK:- UserDefault value for filter
enum FilterKeyValues: Int{
    case Rank = 0, WeeksOnList
}
