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
    
    func diffDate(toDate: Date) -> DateComponents{
        return Calendar.current.dateComponents([.day, .hour, .minute], from: self, to: toDate)
    }
    
    
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
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func lastDayInMonth() -> Int {
        let lastDate = self.endOfMonth()
        return Calendar.current.component(.day, from: lastDate)
    }
    func getMonth() -> Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
    func getDay() -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    func formatDate(format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension Int {
//    =1: Chỉ mua tại web đã chỉ định
//    =2: Đúng sản phẩm, giá cạnh tranh, không chỉ định nơi mua
//    =3: Hàng có sẵn
//    =4: Chỉ mua khi có giảm giá
    func toProductOptionName() -> String {
        switch self {
        case 1:
            return "Chỉ mua tại web đã chỉ định"
        case 2:
            return "Đúng sản phẩm, giá cạnh tranh, không chỉ định nơi mua"
        case 3:
            return "Hàng có sẵn"
        default:
            return "Chỉ mua khi có giảm giá"
        }
    }

    func toDistanceFormated() -> String {

        return "\(self / 1000) km"
    }
}

extension String {
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func share(vc: UIViewController) {
        let vc2 = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        vc.present(vc2, animated: true)
    }
    func openUrl(){
        if let url = URL(string: self),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.openURL(url)
        }
    }
    
    func fromReadableToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" //Your date format
        //        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7:00") //Current time zone
        return dateFormatter.date(from: self) //according to date format your date string
    }

    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        //        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7:00") //Current time zone
        return dateFormatter.date(from: self) //according to date format your date string
    }
    
    func toRaoVatPriceFormat() -> String {
        print("self \(self)")
        if self == "0" || self == "" {
            return "0"
        }
        let price = (Int(self) ?? 0) as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "vi_VN")
        var f = (formatter.string(from: price) ?? "d 0") // $123"
//        let len = f.charactersArray.count - 2
//        f = String(f[..<len])
        
        let numbers = "0123456789 ";
        if let first = f.firstCharacter {
            if numbers.contains(first){
                f = f.substring(to: f.index(f.endIndex, offsetBy: -2))
            } else {
                f = f.substring(from: f.index(f.startIndex, offsetBy: 2))
            }
        }
        return f
    }
    
    func toNumber() -> Int {
        return Int(self.replacingOccurrences(of: ".", with: "")) ?? 0
    }
    
    func convertToLink() -> String {
        return self.hasPrefix("http://") || self.hasPrefix("https://") ? self : "http://\(self)"
    }

    func toFormatedDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        let date = dateFormatterGet.date(from: self)
        return dateFormatterPrint.string(from: date!)
    }
    func toFormatedPrice() -> String {
        return self.toRaoVatPriceFormat() + " VND"
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

    func setAvatar(url: String?) {
        setImage(url: url, placeholder: "avatar")
    }

    func setItem(url: String?) {
        setImage(url: url, placeholder: "sample")
    }

    func setImage(url: String?, placeholder: String) {
        if let url = url {
            self.kf.setImage(with: URL(string: url), placeholder: UIImage(named: placeholder))
        } else {
            self.image = UIImage(named: placeholder)
        }
    }
}

extension Int {
    func toFormatedRaoVatTime() -> String {
        if self > 60 * 24 {
            return "\(self / 60 / 24) ngày trước"
        }
        if self > 60 {
            return "\(self / 60) giờ trước"
        }
        return "\(self) phút trước"
    }
    func toFormatedTime() -> String {
        return self.toFormatedRaoVatTime()
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
    
    
    func toJSONPlace() -> Observable<AleResult> {
        return map { (response) in
            let response = response as! Response
            if response.statusCode != 200 {
                return AleResult.error(msg: "\(response.statusCode) Unhandled Error")
            }
            let json = JSON(response.data)
            print(json)
            return AleResult.done(result: json["predictions"], msg: "")
            
        }
    }
}

extension Collection {
    func toJSONString() -> String {
        let rawData = try! JSONSerialization.data(withJSONObject: self, options: [])
        let jsonData = String(data: rawData, encoding: String.Encoding.utf8)!
        return jsonData
    }
}




