//
//  Extensions.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/29/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift
import SwiftyJSON
import Moya

extension String {
    func convertToLink() -> String {
        return self.hasPrefix("http://") || self.hasPrefix("https://") ? self : "http://\(self)"
    }

    func toFormatedDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        let date = dateFormatterGet.date(from: self)
        return dateFormatterPrint.string(from: date!)
    }
    func toFormatedPrice() -> String {
        return "$" + self
    }

    func loadItemImage(img: UIImageView) {
//        let processor = ResizingImageProcessor(referenceSize: CGSize(width: 100, height: 100))
//        img.kf.setImage(with: URL(string: self), placeholder: UIImage(named: "sample"), options: [.processor(processor)])
        img.kf.setImage(with: URL(string: self), placeholder: UIImage(named: "sample"))
    }
    
    func toFormatedBaoGia() -> String {
        return self + " báo giá"
    }

}
extension Int {

    func toFormatedTime() -> String {
        return "\(self / 60) phút trước"
    }
    
    func toNguoiDangOrNguoiVanChuyen() -> String {
        return self == 0 ? "Người mua" : "Người vận chuyển"
    }
}

extension Float {
    func toFormatedRating() -> String {
        if self.truncatingRemainder(dividingBy: 10) == 0 {
            return "\(Int(self))"
        }
        return String(format: "%.1f", self)

    }
}

func existNil(strs: [Any?]) -> Bool {
    for item in strs {
        if (item == nil) {
            return true
        }
        if "\(item!)" == "" {
            return true
        }
    }
    return false
}


extension ObservableType {
    func toJSON() -> Observable<AleResult> {
        return map { (response) in
            let response = response as! Response
            if response.statusCode != 200 {
                return AleResult.error(msg: "Unhandled Error")
            }
            let json = JSON(response.data)
            print(json)
            if json["code"] == 200 {
                return AleResult.done(result: json["result"])
            } else {
                return AleResult.error(msg: json["message"].string!)
            }
        }
    }
}
