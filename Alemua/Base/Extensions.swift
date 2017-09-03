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


extension Date {
    func toFormatedDuration() -> String {
        let now = Date()
        let components = Calendar.current.dateComponents([.day, .hour, .minute], from: self, to: now)
        
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let min = components.minute ?? 0
        if day > 0 {
            return "\(day) ngày trước"
        }
        if hour > 0 {
            return "\(hour) giờ trước"
        }
        return "\(min) phút trước"
    }
}

extension Int {
    
    func toDistanceFormated() -> String {
        
        return "\(self/1000) km"
    }
}

extension String {
    
    func toRaoVatPriceFormat() -> String {
        let price = (Int(self) ?? 0) as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "vi_VN")
        var f = (formatter.string(from: price) ?? "d 0") // $123"
        f = f.substring(from: f.index(f.startIndex, offsetBy: 2))
        return f
    }
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
        return self + " VND"
    }
    
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss" //Your date format
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7:00") //Current time zone
        return dateFormatter.date(from: self) //according to date format your date string
    }
    func toFormatedHour() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "hh:mm"
//        print(self)
//        let date = self.toDate()
//        return dateFormatter.string(from: date!)
        let str = self.splitted(by: " ")[1]
        
        return str.substring(to: str.index(str.startIndex, offsetBy: 5))
    }
    

//    func loadItemImage(img: UIImageView) {
////        let processor = ResizingImageProcessor(referenceSize: CGSize(width: 100, height: 100))
////        img.kf.setImage(with: URL(string: self), placeholder: UIImage(named: "sample"), options: [.processor(processor)])
//        img.kf.setImage(with: URL(string: self), placeholder: UIImage(named: "sample"))
//    }
//    func loadInto(img: UIImageView) {
//        img.kf.setImage(with: URL(string: self), placeholder: UIImage(named: "sample"))
//    }
    
    func toFormatedBaoGia() -> String {
        return self + " báo giá"
    }

}

extension UIImageView {
    
    func setAvatar(url: String?){
        setImage(url: url, placeholder: "avatar")
    }
    
    func setItem(url: String?){
        setImage(url: url, placeholder: "sample")
    }
    
    func setImage(url: String?, placeholder: String){
        if let url = url {
        self.kf.setImage(with: URL(string: url), placeholder: UIImage(named: placeholder))
        }else{
            self.image = UIImage(named: placeholder)
        }
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
                return AleResult.done(result: json["result"], msg: json["message"].string)
            } else {
                return AleResult.error(msg: json["message"].string!)
            }
        }
    }
}

extension Collection{
    func toJSONString() -> String {
        let rawData = try! JSONSerialization.data(withJSONObject: self, options: [])
        let jsonData = String(data: rawData, encoding: String.Encoding.utf8)!
        return jsonData
    }
}

