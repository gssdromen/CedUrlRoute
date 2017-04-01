//
//  TestViewController.swift
//  test
//
//  Created by cedricwu on 4/1/17.
//  Copyright © 2017 cedricwu. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, CedUrlRouterProtocol {

    required init(params: [String : String]) {
        super.init(nibName: nil, bundle: nil)
        print(params)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
