//
//  CNIntroData.swift
//  testTuto
//
//  Created by Clément NONN on 22/11/2014.
//  Copyright (c) 2014 Clément NONN. All rights reserved.
//

import Foundation

public struct CNIntroData : Equatable {
    var title: String
    var description: String
    var header: UIView?
    var image: UIImage
    
    public init(title: String, description: String, header: UIView? = nil, image: UIImage){
        self.title = title
        self.description = description
        self.header = header
        self.image = image
    }
}

public func ==(data1: CNIntroData, data2: CNIntroData) -> Bool {
    return data1.title == data2.title && data1.description == data2.description && data1.header == data2.header && data1.image == data2.image
}

public func !=(data1: CNIntroData, data2: CNIntroData) -> Bool {
    return !(data1 == data2)
}