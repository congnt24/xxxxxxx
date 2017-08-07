//
//  PictureHelper.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/5/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import MobileCoreServices

public class PictureHelper {
    public class func useCamera(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate, vc: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = delegate
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            vc.present(imagePicker, animated: true,
                       completion: nil)
            //return imagePicker
        }
        //return nil
    }
    public class func pickPhoto(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate, vc: UIViewController) {
//        if UIImagePickerController.isSourceTypeAvailable(
//            UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = delegate
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            vc.present(imagePicker, animated: true,
                       completion: nil)
            //return imagePicker
//        }
        //return nil
    }
}
