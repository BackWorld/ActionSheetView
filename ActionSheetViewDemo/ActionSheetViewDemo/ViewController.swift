//
//  ViewController.swift
//  ActionSheetViewDemo
//
//  Created by zhuxuhong on 2017/3/20.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let items = ["蔬菜", "水果", "食物"]
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actionOfButtonClick(_ sender: UIButton){
        ActionSheetView.show(items: items)
        {[unowned self] (index) in
            self.selectedIndex = index
        }
    }

}

