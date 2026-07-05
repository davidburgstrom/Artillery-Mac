//
//  ViewController.swift
//  Artillery
//
//  Created by David Burgstrom on 7/4/26.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    // UI Controls
    var angleSlider: NSSlider!
    var velocitySlider: NSSlider!
    var angleLabel: NSTextField!
    var velocityLabel: NSTextField!
    var fireButton: NSButton!
    var playerLabel: NSTextField!
    
    // Reference to the game scene
    var gameScene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            // Create our GameScene programmatically (not from .sks file)
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            
            // Store reference to scene
            gameScene = scene
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        setupUI()
    }
    
    // Create and position UI controls
    func setupUI() {
        let view = self.view
        
        let padding: CGFloat = 20
        let controlWidth: CGFloat = 200
        let controlHeight: CGFloat = 24
        
        // Player indicator label (top left)
        playerLabel = NSTextField(labelWithString: "Player 1's Turn")
        playerLabel.font = NSFont.boldSystemFont(ofSize: 16)
        playerLabel.textColor = NSColor.blue
        playerLabel.frame = NSRect(x: padding, y: view.bounds.height - padding - controlHeight, width: controlWidth, height: controlHeight)
        view.addSubview(playerLabel)
        
        // Angle label
        angleLabel = NSTextField(labelWithString: "Angle: 45°")
        angleLabel.frame = NSRect(x: padding, y: view.bounds.height - padding - controlHeight * 3, width: controlWidth, height: controlHeight)
        view.addSubview(angleLabel)
        
        // Angle slider (0-90 degrees)
        angleSlider = NSSlider(value: 45, minValue: 0, maxValue: 90, target: self, action: #selector(angleChanged))
        angleSlider.frame = NSRect(x: padding, y: view.bounds.height - padding - controlHeight * 4, width: controlWidth, height: controlHeight)
        view.addSubview(angleSlider)
        
        // Velocity label
        velocityLabel = NSTextField(labelWithString: "Velocity: 300")
        velocityLabel.frame = NSRect(x: padding, y: view.bounds.height - padding - controlHeight * 6, width: controlWidth, height: controlHeight)
        view.addSubview(velocityLabel)
        
        // Velocity slider (100-500 points/second)
        velocitySlider = NSSlider(value: 300, minValue: 100, maxValue: 500, target: self, action: #selector(velocityChanged))
        velocitySlider.frame = NSRect(x: padding, y: view.bounds.height - padding - controlHeight * 7, width: controlWidth, height: controlHeight)
        view.addSubview(velocitySlider)
        
        // Fire button
        fireButton = NSButton(title: "Fire!", target: self, action: #selector(firePressed))
        fireButton.bezelStyle = .rounded
        fireButton.frame = NSRect(x: padding, y: view.bounds.height - padding - controlHeight * 9, width: controlWidth, height: controlHeight + 8)
        view.addSubview(fireButton)
    }
    
    // Called when angle slider changes
    @objc func angleChanged() {
        let angle = angleSlider.doubleValue
        angleLabel.stringValue = String(format: "Angle: %.0f°", angle)
        
        // Update the current player's angle in the game scene
        gameScene?.updateCurrentPlayerAngle(angle: CGFloat(angle))
    }
    
    // Called when velocity slider changes
    @objc func velocityChanged() {
        let velocity = velocitySlider.doubleValue
        velocityLabel.stringValue = String(format: "Velocity: %.0f", velocity)
        
        // Update the current player's velocity in the game scene
        gameScene?.updateCurrentPlayerVelocity(velocity: CGFloat(velocity))
    }
    
    // Called when fire button is pressed
    @objc func firePressed() {
        gameScene?.fire()
    }
    
    // Update the player label to show whose turn it is
    func updatePlayerLabel(playerNumber: Int) {
        playerLabel.stringValue = "Player \(playerNumber)'s Turn"
        playerLabel.textColor = playerNumber == 1 ? NSColor.blue : NSColor.red
    }
}

