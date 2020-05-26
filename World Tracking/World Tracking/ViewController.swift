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
        let node = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))

        // Add color / light
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange // white light will reflect off, but you need light
        
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        boxNode.geometry?.firstMaterial?.specular.contents = UIColor.orange
        
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        
        // Node Positioning
        node.position = SCNVector3(0.2, 0.3, -0.2)
        boxNode.position = SCNVector3(0, -0.05, 0)
        doorNode.position = SCNVector3(0, -0.02, 0.053)
        
        // Add node to scene
        sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
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

