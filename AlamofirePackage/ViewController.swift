//
//  ViewController.swift
//  AlamofirePackage
//
//  Created by Jakin on 2017/10/22.
//  Copyright © 2017年 Jakin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let api = TestApi();
        api.getUserInfo { (flg) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

