//
//  ViewController.swift
//  happyBirthdayDad
//
//  Created by Virgil Martinez on 3/9/18.
//  Copyright © 2018 Virgil Alexander Martinez. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        
        // Root node
        let node = SCNNode()
        let boxNode = SCNNode()
        // Cylinder
        let cylinder = SCNCylinder(radius: 0.01, height: 0.8)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/wood.jpg")
        cylinder.materials = [material]
        node.position = SCNVector3(0,-0.6,-0.8)
        node.geometry = cylinder
        sceneView.scene.rootNode.addChildNode(node)
        
        let sign = SCNBox(width: 0.35, height: 0.2, length: 0.02, chamferRadius: 0)
        sign.materials = [material]
        node.addChildNode(boxNode)
        boxNode.geometry = sign
        boxNode.position = SCNVector3(0,0.33,0.02)
        // Lighting
        sceneView.autoenablesDefaultLighting = true
        
        // Debug stuffs
        //sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
