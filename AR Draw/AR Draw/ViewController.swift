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
    @IBOutlet var sceneView: ARSCNView!
    
    @IBAction func buttonPressed(_ sender: Any) {
        
    }
    
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sceneView.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        sceneView.showsStatistics = true
        sceneView.delegate = self
        sceneView.session.run(config)
    }
    
    // MARK: - ARSCNViewDelegate Methods
    public func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        print("rendering...")
    }
}

