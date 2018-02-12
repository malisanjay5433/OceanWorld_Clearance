//
//  HomeViewController.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 06/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
import KRProgressHUD
import KRActivityIndicatorView

class HomeViewController: UIViewController {
    let app = AppColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = app.hexStringToUIColor(hex: "0D91CE")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showSuccessButtonTapped(withSender sender: UIButton) {
        KRProgressHUD.showSuccess(withMessage: "Success!")
    }
    
    @IBAction func showInfoButtonTapped(withSender sender: UIButton) {
        KRProgressHUD.showInfo(withMessage:"Info")
    }
    
    @IBAction func showWarningButtonTapped(withSender sender: UIButton) {
        KRProgressHUD.showWarning(withMessage:"Warning!")
    }
    
    @IBAction func showErrorButtonTapped(withSender sender: UIButton) {
        KRProgressHUD.showError(withMessage: "Error...")
    }
    
    @IBAction func showWithImageButtonTapped(withSender sender: UIButton) {
        let image = UIImage(named: "image.png")!
        KRProgressHUD.showImage(image, message:"Custom image")
    }


}
