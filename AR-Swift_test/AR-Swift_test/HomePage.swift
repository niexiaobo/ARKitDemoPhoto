//
//  HomePage.swift
//  AR-Swift_test
//
//  Created by niexiaobo on 2019/3/20.
//  Copyright © 2019 niexiaobo. All rights reserved.
//

import Foundation

import UIKit
import SceneKit
import ARKit

class HomePage: UIViewController,ARSCNViewDelegate {
    let spotLight = SCNLight()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func gotoArtPic(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let ArtTreeView = story.instantiateViewController(withIdentifier: "ViewControllerID")
        let vc = ArtTreeView as! ViewController
        vc.arIndex = 0
        self.navigationController?.pushViewController(ArtTreeView, animated: true)
    }
    @IBAction func gotoArtPic1(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let ArtTreeView = story.instantiateViewController(withIdentifier: "ViewControllerID")
        let vc = ArtTreeView as! ViewController
        vc.arIndex = 1
        self.navigationController?.pushViewController(ArtTreeView, animated: true)
    }
    @IBAction func gotoArtPic2(_ sender: Any) {
//        let AlertVVC = AlertViewController()
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        let ArtTreeView = story.instantiateViewController(withIdentifier: "ViewControllerID")
        let vc = ArtTreeView as! ViewController
        vc.arIndex = 2
        //ArtTreeView.arIndex = 2;
        self.navigationController?.pushViewController(ArtTreeView, animated: true)
    }
    
}

