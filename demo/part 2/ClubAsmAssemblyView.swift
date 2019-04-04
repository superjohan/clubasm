//
//  ClubAsmAssemblyView.swift
//  demo
//
//  Created by Johan Halin on 04/04/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import UIKit
import SceneKit

class ClubAsmAssemblyView: UIView, ClubAsmActions {
    private let sceneView = SCNView()
    private let camera = SCNNode()
    private let assemblyLogo = loadModel(name: "asm_a", textureName: nil, color: UIColor.init(white: 0.95, alpha: 1.0))

    override init(frame: CGRect) {
        let camera = SCNCamera()
        camera.zFar = 600
        camera.vignettingIntensity = 1
        camera.vignettingPower = 1
        camera.colorFringeStrength = 2
        camera.bloomIntensity = 1
        camera.bloomBlurRadius = 40
        camera.motionBlurIntensity = 1.5
        self.camera.camera = camera // lol

        super.init(frame: frame)
        
        self.sceneView.backgroundColor = .black
//        self.sceneView.delegate = self
        self.sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(self.sceneView)
        
        self.sceneView.scene = createScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var animating = false
    
    func action1() {
        if self.animating { return }

        self.animating = true
    }
    
    func action2() {
    }
    
    func action3() {
    }
    
    func action4() {
    }
    
    func action5() {
    }
    
    private func createScene() -> SCNScene {
        let scene = SCNScene()
        scene.background.contents = UIColor.black
        
        self.camera.position = SCNVector3Make(0, 10, 20)
        self.camera.rotation = SCNVector4Make(-0.2, 0, 0, 0.5)
        scene.rootNode.addChildNode(self.camera)
        
        self.assemblyLogo.position = SCNVector3Make(0, 0, 0)
//        self.assemblyLogo.scale = SCNVector3Make(3, 3, 3)
        scene.rootNode.addChildNode(self.assemblyLogo)

        configureLight(scene)
        
        let starField = SCNParticleSystem(named: "stars", inDirectory: nil)!
        scene.rootNode.addParticleSystem(starField)
        
        return scene
    }
    
    private func configureLight(_ scene: SCNScene) {
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light?.type = SCNLight.LightType.omni
        omniLightNode.light?.color = UIColor(white: 1.0, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 0, 60)
        scene.rootNode.addChildNode(omniLightNode)
    }
    
    // MARK: - SCNSceneRendererDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // this function is run in a background thread.
        //        DispatchQueue.main.async {
        //        }
    }
}
