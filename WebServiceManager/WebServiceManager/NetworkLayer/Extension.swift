//
//  Extension.swift
//  WebServiceManager
//
//  Created by Malik Wahaj Ahmed on 10/04/2017.
//  Copyright © 2017 Malik Wahaj Ahmed. All rights reserved.
//

import Foundation


enum ImageType: String {
    
    case png
    case jpeg
}

extension RawRepresentable where RawValue: Any {
    /**
     * The name of the enumeration (as written in case).
     */
    var name: String {
        get { return String(describing: self) }
    }
    
    /**
     * The full name of the enumeration
     * (the name of the enum plus dot plus the name as written in case).
     */
    var description: String {
        get { return String(reflecting: self) }
    }
}
