//
//  GameScene.swift
//  Artillery
//
//  Created by David Burgstrom on 7/4/26.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Game models
    var terrain: Terrain?
    var player1: Player?
    var player2: Player?
    
    // Visual nodes
    var terrainNode: SKShapeNode?
    var player1Node: SKShapeNode?
    var player2Node: SKShapeNode?
    
    override func didMove(to view: SKView) {
        // Set sky background color
        backgroundColor = NSColor(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.0)
        
        setupGame()
    }
    
    // Initialize game state and visuals
    func setupGame() {
        // Create terrain
        terrain = Terrain(width: size.width, baseHeight: 100)
        
        // Position players on opposite sides of the screen
        // Player 1 on the left (20% from left edge)
        let p1X = size.width * 0.2
        let p1Y = terrain!.heightAt(x: p1X)
        player1 = Player(playerNumber: 1, position: CGPoint(x: p1X, y: p1Y))
        
        // Player 2 on the right (80% from left edge)
        let p2X = size.width * 0.8
        let p2Y = terrain!.heightAt(x: p2X)
        player2 = Player(playerNumber: 2, position: CGPoint(x: p2X, y: p2Y))
        
        // Draw everything
        drawTerrain()
        drawPlayers()
    }
    
    // Draw the terrain as a filled polygon
    func drawTerrain() {
        // Remove old terrain if it exists
        terrainNode?.removeFromParent()
        
        guard let terrain = terrain else { return }
        
        // Create a path that traces the terrain outline
        let path = CGMutablePath()
        
        // Start at bottom left
        path.move(to: CGPoint(x: 0, y: 0))
        
        // Trace along the terrain heights
        for x in 0..<Int(terrain.width) {
            let h = terrain.heightAt(x: CGFloat(x))
            path.addLine(to: CGPoint(x: CGFloat(x), y: h))
        }
        
        // Complete the polygon by going to bottom right and back to start
        path.addLine(to: CGPoint(x: terrain.width, y: 0))
        path.closeSubpath()
        
        // Create shape node with the path
        terrainNode = SKShapeNode(path: path)
        terrainNode?.fillColor = NSColor(red: 0.4, green: 0.6, blue: 0.3, alpha: 1.0)
        terrainNode?.strokeColor = NSColor(red: 0.2, green: 0.4, blue: 0.2, alpha: 1.0)
        terrainNode?.lineWidth = 2
        
        addChild(terrainNode!)
    }
    
    // Draw both players as triangles
    func drawPlayers() {
        drawPlayer(player: player1!, node: &player1Node, color: NSColor.blue)
        drawPlayer(player: player2!, node: &player2Node, color: NSColor.red)
    }
    
    // Draw a single player as a triangle
    // The triangle is equilateral with base = 20 points
    func drawPlayer(player: Player, node: inout SKShapeNode?, color: NSColor) {
        // Remove old node if it exists
        node?.removeFromParent()
        
        // Create triangle path (pointing upward)
        let path = CGMutablePath()
        let size: CGFloat = 20
        
        // Triangle vertices: top point, bottom left, bottom right
        path.move(to: CGPoint(x: 0, y: size * 0.866))  // top (0.866 ≈ sqrt(3)/2 for equilateral)
        path.addLine(to: CGPoint(x: -size/2, y: 0))    // bottom left
        path.addLine(to: CGPoint(x: size/2, y: 0))     // bottom right
        path.closeSubpath()
        
        node = SKShapeNode(path: path)
        node?.fillColor = color
        node?.strokeColor = color.withAlphaComponent(0.8)
        node?.lineWidth = 2
        node?.position = player.position
        
        addChild(node!)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
