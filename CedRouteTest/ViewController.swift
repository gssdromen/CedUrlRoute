//
//  ViewController.swift
//  CedRouteTest
//
//  Created by cedricwu on 4/1/17.
//  Copyright © 2017 cedricwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red

//        CedUrlRouter.shared.register(key: "esf_house", clazz: TestViewController.self)
        CedUrlRouter.shared.register(key: "esf_house", className: "CedRouteTest.TestViewController")

        let url = "esf://esf_house?houseId=123456&agentId=111111"

        let result = CedUrlRouter.shared.parseUrl(url: url)

        let vc = CedUrlRouter.shared.getObjectFor(parseResult: result!)

        if vc is UIViewController {
            navigationController?.pushViewController(vc as! UIViewController, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

