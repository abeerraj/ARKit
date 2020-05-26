//
//  ViewController.swift
//  World Tracking
//
//  Created by Jacob Rozell on 5/26/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import ARKit
import UIKit

class ViewController: UIViewController {
    
    // Variables
    @IBOutlet var sceneView: ARSCNView!
    let arConfig = ARWorldTrackingConfiguration()
    
    // IBActions
    @IBAction func addPressed(_ sender: Any) {
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03) // divide chamferRadius by 2 to generate sphere
        
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange // white light will reflect off, but you need light
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.position = SCNVector3(randomNumbers(), // X
                                   randomNumbers(), // Y
                                   randomNumbers()) // Z
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        self.resetSession()
    }
    
    // Functions
    func resetSession() {
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        sceneView.session.run(arConfig, options: [.resetTracking, .removeExistingAnchors])
    }
    
    /// Returns random range in range firstNum...secondNum
    func randomNumbers(firstNum: CGFloat = -0.3, secondNum: CGFloat = 0.3) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    // ViewCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        sceneView.session.run(arConfig)
        
        sceneView.autoenablesDefaultLighting = true // auto adds onmi-directional light source
    }
}

