//
//  AlemuaResult.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/6/17.
//  Copyright © 2017 cong. All rights reserved.
//

import SwiftyJSON

public enum AleResult {
    case done(result: JSON)
    case error(msg: String)
}
