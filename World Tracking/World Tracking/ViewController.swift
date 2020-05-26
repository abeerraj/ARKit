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
        
        // Custom House Shape \\
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.2))
        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        path.addLine(to: CGPoint(x: 0.4, y: 0))
        
        node.geometry = SCNShape(path: path, extrusionDepth: 0.2)
        
        // Pyramid \\
//        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        
        // Plane \\
//        node.geometry = SCNPlane(width: 0.2, height: 0.2)
        
        // Torus \\
//        node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
        
        // Tube \\
//        node.geometry = SCNTube(innerRadius: 0.1, outerRadius: 0.2, height: 0.5)
        
        // Sphere \\
//        node.geometry = SCNSphere(radius: 0.3)
        
        // Cylinder \\
//        node.geometry = SCNCylinder(radius: 0.2, height: 0.2)
        
        // Cone \\
//        node.geometry = SCNCone(topRadius: 0, bottomRadius: 0.2, height: 0.2)
        
        // Capsule \\
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
        
        // Box \\
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        
        // Add light
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange // white light will reflect off, but you need light
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        // Generate random position in range -0.3...0.3
        node.position = SCNVector3(randomNumbers(), // X
                                   randomNumbers(), // Y
                                   randomNumbers()) // Z
        
        // Add node to scene
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

