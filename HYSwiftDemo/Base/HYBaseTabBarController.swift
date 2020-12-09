//
//  HYBaseTabBarController.swift
//  HYSwiftDemo
//
//  Created by axc on 2020/11/25.
//  Copyright © 2020 axc. All rights reserved.
//

import UIKit

class HYBaseTabBarController: UITabBarController {

    deinit {
        print("deinit_____\(self.classForCoder)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
