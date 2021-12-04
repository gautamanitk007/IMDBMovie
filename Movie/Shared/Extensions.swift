//
//  Extensions.swift
//  Movie
//
//  Created by Gautam Singh on 4/12/21.
//

import Foundation

extension String{
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    var intValue: Int {
        return (self as NSString).integerValue
    }
    var boolValue: Bool{
        return (self as NSString).boolValue
    }
}
