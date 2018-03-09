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
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        
        // Root node
        let node = SCNNode()
        let boxNode = SCNNode()
        let imageNode = SCNNode()
        let imageNode2 = SCNNode()
        let whiteNode = SCNNode()
        
        
        // Cylinder
        let cylinder = SCNCylinder(radius: 0.01, height: 0.8)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/wood.jpg")
        cylinder.materials = [material]
        node.position = SCNVector3(0,-0.6,-1)
        node.geometry = cylinder
        sceneView.scene.rootNode.addChildNode(node)
        // Sign
        let sign = SCNBox(width: 0.35, height: 0.2, length: 0.02, chamferRadius: 0)
        sign.materials = [material]
        node.addChildNode(boxNode)
        boxNode.geometry = sign
        boxNode.position = SCNVector3(0,0.33,0.02)
            // On sign
        let whiteSpace = SCNBox(width: 0.32, height: 0.17, length: 0.01, chamferRadius: 0)
        let whiteMaterial = SCNMaterial()
        whiteMaterial.diffuse.contents = UIImage(named: "art.scnassets/birthdayCard.jpg")
        whiteSpace.materials = [whiteMaterial]
        whiteNode.geometry = whiteSpace
        boxNode.addChildNode(whiteNode)
        whiteNode.position = SCNVector3(0,0,0.011)
        
        
        
        // Posters
        
        // Heavy Metal
        let image = SCNBox(width: 1.2, height: 0.86, length: 0.01, chamferRadius: 0)
        let imageMaterial = SCNMaterial()
        imageMaterial.diffuse.contents = UIImage(named: "art.scnassets/heavymetal.jpg")
        image.materials = [imageMaterial]
        imageNode.geometry = image
        node.addChildNode(imageNode)
        imageNode.position = SCNVector3(0,1,-0.9)
        
        // Thin lizzy
        let image2 = SCNBox(width: 0.8, height: 0.63, length: 0.01, chamferRadius: 0)
        let image2Material = SCNMaterial()
        image2Material.diffuse.contents = UIImage(named: "art.scnassets/thinlizzy.jpg")
        image2.materials = [image2Material]
        imageNode2.geometry = image2
        node.addChildNode(imageNode2)
        imageNode2.position = SCNVector3(-1.2,0.89,-0.5)
        imageNode2.eulerAngles = SCNVector3(0.4,0.8,0)
        
        // TAMU
        let image3 = SCNBox(width: 0.8, height: 0.63, length: 0.001, chamferRadius: 0)
        let image3Material = SCNMaterial()
        let imageNode3 = SCNNode()
        image3Material.diffuse.contents = UIImage(named: "art.scnassets/tamu.png")
        image3.materials = [image3Material]
        imageNode3.geometry = image3
        node.addChildNode(imageNode3)
        imageNode3.position = SCNVector3(1.4,0.82,-0.6)
        imageNode3.eulerAngles = SCNVector3(0.4,-0.8,0)
        
        
        //guitar
        let guitarScene = SCNScene(named: "art.scnassets/guitar.scn")
        if let guitarNode = guitarScene?.rootNode {
            node.addChildNode(guitarNode)
            guitarNode.position = SCNVector3(0.55,-0.3,0)
            //guitarNode.eulerAngles = SCNVector3(-0.9,0.5,1)
        }
        
        
        
        
        
        // Lighting
        sceneView.autoenablesDefaultLighting = true
        
        //Background Music
        playSound()

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

    func playSound() {
        guard let url = Bundle.main.url(forResource: "heavymetal", withExtension: "mp3") else {return}
        
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else {return}
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        
    }
}
