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
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.position = SCNVector3(0, 0, -0.3) // X, Y, Z
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        self.resetSession()
    }
    
    func resetSession() {
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        sceneView.session.run(arConfig, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // ViewCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        sceneView.session.run(arConfig)
    }
}

