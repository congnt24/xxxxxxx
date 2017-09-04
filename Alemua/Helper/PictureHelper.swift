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
    
    public class func showDialogChoosePhoto(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate, vc: UIViewController){
        let alert = UIAlertController(title: "Choose Photo", message: "Please Select A Media", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let photo = UIAlertAction(title: "Photo", style: .default) { (imageAction) in
            PictureHelper.pickPhoto(delegate: delegate, vc: vc)
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { (videoAction) in
            PictureHelper.useCamera(delegate: delegate, vc: vc)
        }
        alert.addAction(photo)
        alert.addAction(camera)
        alert.addAction(cancel)
       vc.present(alert, animated: true, completion: nil)

    }
}
