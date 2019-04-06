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
    private let logoWrapper = SCNNode()
//    private let assemblyLogo = loadModel(name: "asm_a", textureName: nil, color: UIColor.init(white: 0.95, alpha: 1.0))
    private var assemblyLogo: SCNNode?
    private var starField: SCNParticleSystem?
    private var explosion: SCNParticleSystem?
    
    private var position = 0
    
    override init(frame: CGRect) {
        let camera = SCNCamera()
        camera.zFar = 600
        camera.vignettingIntensity = 1
        camera.vignettingPower = 1
        camera.colorFringeStrength = 0.5
        camera.bloomIntensity = 0.25
        camera.bloomBlurRadius = 20
        camera.wantsHDR = true
        camera.motionBlurIntensity = 1

//        camera.wantsDepthOfField = true
//        camera.focusDistance = 0.075
//        camera.fStop = 1
//        camera.apertureBladeCount = 10
//        camera.focalBlurSampleCount = 100

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
        if self.position == 0 {
            let duration = ClubAsmConstants.barLength * 8
            
            let rotateAction = SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: duration)
            rotateAction.timingMode = .easeIn
            self.camera.runAction(rotateAction)
            
            let cameraPositionAction = SCNAction.move(to: SCNVector3Make(0, 0, 20), duration: duration)
            cameraPositionAction.timingMode = .easeOut
            self.camera.runAction(cameraPositionAction)
            
            let logoRotateAction = SCNAction.rotateBy(x: 0, y: CGFloat.pi * 2, z: 0, duration: 5)
            logoRotateAction.timingMode = .linear
            self.assemblyLogo?.runAction(SCNAction.repeatForever(logoRotateAction))
            
            let logoPositionAction = SCNAction.move(to: SCNVector3Make(0, 0, 0), duration: duration)
            logoPositionAction.timingMode = .easeOut
            self.logoWrapper.runAction(logoPositionAction)
        }
        
        if self.position == 4 {
            self.starField?.loops = false
        }
        
        if self.position == 6 {
            let duration = ClubAsmConstants.barLength * 2

            let logoFlightRotationAction = SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: duration)
            logoFlightRotationAction.timingMode = .easeInEaseOut
            self.logoWrapper.runAction(logoFlightRotationAction)
        }
        
        if self.position == 8 {
            self.sceneView.scene?.rootNode.addParticleSystem(self.explosion!)
        }
        
        self.position += 1
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
        self.camera.rotation = SCNVector4Make(-0.2, 0, 0, 1)
        scene.rootNode.addChildNode(self.camera)
        
//        self.assemblyLogo.position = SCNVector3Make(0, 0, 0)
//        self.assemblyLogo.scale = SCNVector3Make(3, 3, 3)
//        scene.rootNode.addChildNode(self.assemblyLogo)

        let box = SCNBox(width: 8, height: 11, length: 2, chamferRadius: 0)
        box.firstMaterial?.diffuse.contents = UIColor.gray
        box.firstMaterial?.lightingModel = .physicallyBased
        let boxNode = SCNNode(geometry: box)
        boxNode.renderingOrder = 1
        self.assemblyLogo = boxNode

        self.logoWrapper.position = SCNVector3Make(0, -20, 25)
        self.logoWrapper.addChildNode(self.assemblyLogo!)
        self.logoWrapper.rotation = SCNVector4Make(1, 0, 0, -Float.pi / 2.0)
        scene.rootNode.addChildNode(self.logoWrapper)
        
        configureLight(scene)
        
        let starField = SCNParticleSystem(named: "stars", inDirectory: nil)!
        let starFieldNode = SCNNode()
        starFieldNode.addParticleSystem(starField)
        scene.rootNode.addChildNode(starFieldNode)
        self.starField = starField

        self.explosion = SCNParticleSystem(named: "boom", inDirectory: nil)
        
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
