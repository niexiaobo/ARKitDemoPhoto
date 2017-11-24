//
//  ViewController.swift
//  AR-Swift_test
//
//  Created by niexiaobo on 2017/11/16.
//  Copyright © 2017年 niexiaobo. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    let spotLight = SCNLight()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func gotoArtPic(_ sender: Any) {
        let ArtTreeView = ArtTreeViewController()
        ArtTreeView.arIndex = 0;
        self.navigationController?.pushViewController(ArtTreeView, animated: true)
    }
    @IBAction func gotoArtPic1(_ sender: Any) {
        let ArtTreeView = ArtTreeViewController()
        ArtTreeView.arIndex = 1;
        self.navigationController?.pushViewController(ArtTreeView, animated: true)
    }
    @IBAction func gotoArtPic2(_ sender: Any) {
        let ArtTreeView = ArtTreeViewController()
        ArtTreeView.arIndex = 2;
        //self.present(ArtTreeView, animated: true, completion: nil)
        self.navigationController?.pushViewController(ArtTreeView, animated: true)
    }

}

