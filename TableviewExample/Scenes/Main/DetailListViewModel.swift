//
//  DetailListViewModel.swift
//  TableviewExample
//
//  Created by Kittiphong Xayasane on 2020-04-10.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

import Foundation

class DetailListViewModel {
    var someProperty: Bool = false {
        didSet {
            someClosure?()
        }
    }
    
    var someClosure: (()->())?
}
