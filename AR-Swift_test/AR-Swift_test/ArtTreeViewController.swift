//
//  ArtTreeViewController.swift
//  AR-Swift_test
//
//  Created by niexiaobo on 2017/11/16.
//  Copyright © 2017年 niexiaobo. All rights reserved.
//

import UIKit
//引入ARkit所需的包
import ARKit
//引入 SceneKit
import SceneKit
class ArtTreeViewController: UIViewController,ARSCNViewDelegate {
    //必备
    let arSCNView = ARSCNView()
    let arSession = ARSession()
    let arConfiguration = ARWorldTrackingConfiguration()
    
    var arIndex = 0
    //图
    let ArtPicNode = SCNNode()
    
    let ArtPicHaloNode = SCNNode()//光晕
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        arConfiguration.isLightEstimationEnabled = true//自适应灯光（室內到室外的話 畫面會比較柔和）
        arSession.run(arConfiguration, options: [.removeExistingAnchors,.resetTracking])
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        arSession.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置arSCNView属性
        arSCNView.frame = self.view.frame
        
        arSCNView.session = arSession
        arSCNView.automaticallyUpdatesLighting = true//自动调节亮度
        
        self.view.addSubview(arSCNView)
        arSCNView.delegate = self
        
        self.initNode()
        self.addLight()
        for i in 0..<6{
            self.addBtns(index: i)
        }
    }
    

    //MARK:初始化节点信息
    func initNode()  {
        //1.设置几何
        //ArtPicNode.geometry = SCNSphere(radius: 3) //球形
        //图片
        var boxW: CGFloat = 6
        var boxH: CGFloat = 6
        let boxL: CGFloat = 0.1
        if self.arIndex == 0 {
            boxH = 9
        } else if self.arIndex == 1 {
            boxH = 5
        } else if self.arIndex == 2 {
            boxW = 10
        }
        
        //创建一个长方体,用来展示图片
        ArtPicNode.geometry = SCNBox.init(width: boxW, height: boxH, length: boxL, chamferRadius: 0.1) //方形
        
        let imageA =  ["timgKuang.jpg","timg2kuang.jpg","timg3Kuang.jpg"];
        
        ArtPicNode.geometry?.firstMaterial?.diffuse.contents = imageA[self.arIndex]
        ArtPicNode.geometry?.firstMaterial?.multiply.intensity = 0.5 //強度
        ArtPicNode.geometry?.firstMaterial?.lightingModel = SCNMaterial.LightingModel.constant
        
        
        //3.设置位置
        ArtPicNode.position = SCNVector3(0, 5, -20)
        //添加长方体到界面上
        self.arSCNView.scene.rootNode.addChildNode(ArtPicNode)
        
    }
   
    
    func addLight() {
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.color = UIColor.red //被光找到的地方颜色
        
        ArtPicNode.addChildNode(lightNode)
        lightNode.light?.attenuationEndDistance = 20.0 //光照的亮度随着距离改变
        lightNode.light?.attenuationStartDistance = 1.0
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 1
        lightNode.light?.color =  UIColor.white
        lightNode.opacity = 0.5 // make the halo stronger
        
        SCNTransaction.commit()
        ArtPicHaloNode.geometry = SCNPlane.init(width: 25, height: 25)
        
        ArtPicHaloNode.rotation = SCNVector4Make(1, 0, 0, Float(0 * Double.pi / 180.0))
        ArtPicHaloNode.geometry?.firstMaterial?.diffuse.contents = "sun-halo.png"
        ArtPicHaloNode.geometry?.firstMaterial?.lightingModel = SCNMaterial.LightingModel.constant // no lighting
        ArtPicHaloNode.geometry?.firstMaterial?.writesToDepthBuffer = false // 不要有厚度，看起来薄薄的一层
        ArtPicHaloNode.opacity = 5
        ArtPicHaloNode.addChildNode(ArtPicHaloNode)
    }
    
    
    func addBtns(index: NSInteger) {
        
        let colorA = [UIColor.red,UIColor.green,UIColor.blue,UIColor.orange,UIColor.purple,UIColor.red,UIColor.purple];
        let titleA = ["左","上","下","右","前","后","添加"];
        
        let btnW = self.view.frame.size.width/6.0;
        let btnH = 50.0;
        var org_x = 0.0;
        var org_y = self.view.frame.size.height - 50.0;
        if (index == 0) {//左
            org_x = Double(btnW * 1.5);
            org_y = self.view.frame.size.height - 100;
        } else if (index == 1) {//上
            org_x = Double(btnW * 2.5);
            org_y = self.view.frame.size.height - 150;
        } else if (index == 2) {//下
            org_x = Double(btnW * 2.5);
            org_y = self.view.frame.size.height - 50;
        } else if (index == 3) {//右
            org_x = Double(btnW * 3.5);
            org_y = self.view.frame.size.height - 100;
        } else if (index == 4) {//前
            org_x = 15;
            org_y = self.view.frame.size.height - 100;
        } else if (index == 5) {//后
            org_x = Double(self.view.frame.size.width - btnW - 15.0);
            org_y = self.view.frame.size.height - 100;
        } else if (index == 6) {//add
            org_x = Double(btnW * 2.5);
            org_y = self.view.frame.size.height - 100;
        }
        
        //创建一个ContactAdd类型的按钮
        let button:UIButton = UIButton(type:.contactAdd)
        //设置按钮位置和大小
        button.frame = CGRect(x: CGFloat(org_x), y: CGFloat(org_y), width: CGFloat(btnW), height: CGFloat(btnH))
        //设置按钮文字
        button.setTitle(titleA[index], for:.normal)
        button.setTitleColor(UIColor.white, for: .normal) //普通状态下文字的颜色
        //传递触摸对象（即点击的按钮），需要在定义action参数时，方法名称后面带上冒号
        button.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
        button.tag = index
        button.backgroundColor = colorA[index]
        self.view.addSubview(button)
        
    }
    
    @objc func tapped(_ button:UIButton){
        
        var vector = SCNVector3.init()
        vector = ArtPicNode.position
        
        let dat: Float = 1
        
        if (button.tag == 0) {
            vector.x = vector.x - dat
        } else if (button.tag == 1) {
            vector.y += dat
        } else if (button.tag == 2) {
            vector.y -= dat
        } else if (button.tag == 3) {
            vector.x+=dat
        } else if (button.tag == 4) {
            vector.z-=dat
        } else if (button.tag == 5) {
            vector.z+=dat
        }
        ArtPicNode.position = vector;
        
    }
    
    

}
