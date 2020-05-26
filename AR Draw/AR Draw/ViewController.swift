//
//  ViewController.swift
//  AR Draw
//
//  Created by Jacob Rozell on 5/26/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import ARKit
import UIKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    // IBOutlets
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var draw: UIButton!
    
    // ARConfig
    let config = ARWorldTrackingConfiguration()
    
    // LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sceneView.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        sceneView.showsStatistics = false
        sceneView.delegate = self
        sceneView.session.run(config)
    }
    
    // MARK: - ARSCNViewDelegate Methods
    public func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pov = sceneView.pointOfView else { return }
        let transform = pov.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)    // negate to get opposite direction
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let frontOfCamera = orientation + location                                      // This is a SCNVector3 of the front of camera
        
        // Must throw this on the main thread to resolve access errors
        DispatchQueue.main.async {
            
            // If user is pressing button
            if self.draw.isHighlighted {
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
                sphereNode.position = frontOfCamera
                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
                self.sceneView.scene.rootNode.addChildNode(sphereNode)
            }
            
            // User is not pressing button / Create pointer
            else {
                let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
                pointer.name = "pointer"
                pointer.position = frontOfCamera
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
                
                // remove any `pointer` nodes
                self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                    if node.name == "pointer" {
                        node.removeFromParentNode()
                    }
                }
                
                self.sceneView.scene.rootNode.addChildNode(pointer)
            }
        }
    }
}

// Needed to compare two SCNVector3 objects
func +(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
}

