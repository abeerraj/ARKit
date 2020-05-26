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
        let cylinderNode = SCNNode(geometry: SCNCylinder(radius: 0.05, height: 0.05))

        // Add shape
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        
        // Add light
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange // white light will reflect off, but you need light
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
        // Node Positioning
//        node.position = SCNVector3(randomNumbers(), // X
//                                   randomNumbers(), // Y
//                                   randomNumbers()) // Z
        
        node.position = SCNVector3(0.2, 0.3, -0.2)
        cylinderNode.position = SCNVector3(-0.3, 0.2, -0.3)
        
        // Add node to scene
        sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(cylinderNode)
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

