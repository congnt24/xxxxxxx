//
//  Extensions.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/29/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation

extension String {
    func convertToLink() -> String{
        return self.hasPrefix("http://") || self.hasPrefix("https://") ? self : "http://\(self)"
    }
    
}
