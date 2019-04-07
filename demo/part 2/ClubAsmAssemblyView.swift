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
    private let assemblyLogo = loadModel(name: "asm_a", textureName: nil, color: .white)
    private var starField: SCNParticleSystem?
    private var explosion: SCNParticleSystem?
    private let explosionNode = SCNNode()
    private let light = SCNNode()
    private let plasma = SCNNode()
    
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
        camera.wantsExposureAdaptation = false

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
    
    func setupShaders() {
        let plane = SCNPlane(width: 300, height: 300)
        let size = CGSize(width: self.bounds.size.width * UIScreen.main.scale, height: self.bounds.size.height * UIScreen.main.scale)
        applyShader(object: plane, shaderName: "plasma", size: size)
        self.plasma.geometry = plane
        self.plasma.position = SCNVector3Make(0, 0, -100)
        self.plasma.opacity = 0.0001
        self.sceneView.scene?.rootNode.addChildNode(self.plasma)
    }
    
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
            self.assemblyLogo.runAction(SCNAction.repeatForever(logoRotateAction))
            
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
        
        if self.position == 7 {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = ClubAsmConstants.barLength
            SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: .easeOut)
            self.light.light?.color = UIColor(white: 1.0, alpha: 1.0)
            SCNTransaction.commit()
        }
        
        if self.position == 8 {
            self.explosionNode.addParticleSystem(self.explosion!)

            SCNTransaction.begin()
            SCNTransaction.animationDuration = ClubAsmConstants.barLength * 2.0
            SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            self.plasma.opacity = 1
            SCNTransaction.commit()
        }
        
        if self.position == 9 {
            let duration = ClubAsmConstants.barLength
            let logoPositionAction = SCNAction.move(to: SCNVector3Make(0, 3, 0), duration: duration)
            logoPositionAction.timingMode = .easeInEaseOut
            self.logoWrapper.runAction(logoPositionAction)
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
        
        self.assemblyLogo.pivot = SCNMatrix4MakeTranslation(0.021, 0.019, 0.002)
        self.assemblyLogo.scale = SCNVector3Make(300, 300, 500)
        self.assemblyLogo.childNodes[0].geometry?.firstMaterial?.lightingModel = .physicallyBased
        self.assemblyLogo.renderingOrder = 1
        self.assemblyLogo.childNodes[0].renderingOrder = 1

        self.logoWrapper.position = SCNVector3Make(0, -20, 25)
        self.logoWrapper.rotation = SCNVector4Make(1, 0, 0, -Float.pi / 2.0)
        self.logoWrapper.addChildNode(self.assemblyLogo)
        scene.rootNode.addChildNode(self.logoWrapper)
        
        configureLight(scene)
        
        let starField = SCNParticleSystem(named: "stars", inDirectory: nil)!
        let starFieldNode = SCNNode()
        starFieldNode.addParticleSystem(starField)
        scene.rootNode.addChildNode(starFieldNode)
        self.starField = starField

        self.explosionNode.renderingOrder = 1
        scene.rootNode.addChildNode(self.explosionNode)
        
        self.explosion = SCNParticleSystem(named: "boom", inDirectory: nil)
        
        return scene
    }
    
    private func configureLight(_ scene: SCNScene) {
        self.light.light = SCNLight()
        self.light.light?.type = SCNLight.LightType.omni
        self.light.light?.color = UIColor(white: 0, alpha: 1.0)
        self.light.position = SCNVector3Make(0, 0, 60)
        scene.rootNode.addChildNode(self.light)
    }
    
    // MARK: - SCNSceneRendererDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // this function is run in a background thread.
        //        DispatchQueue.main.async {
        //        }
    }
}
