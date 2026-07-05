//
//  Projectile.swift
//  Artillery
//
//  Projectile model - tracks position, velocity, and handles physics
//

import Foundation
import CoreGraphics

class Projectile {
    var position: CGPoint       // current position
    var velocity: CGVector      // current velocity (vx, vy)
    let startTime: TimeInterval // when the projectile was fired
    
    // Physics constants
    let gravity: CGFloat = -500  // gravity acceleration (negative = downward), in points/second²
    
    // Initial state (for physics calculations)
    let initialPosition: CGPoint
    let initialVelocity: CGVector
    
    init(position: CGPoint, angle: CGFloat, speed: CGFloat, startTime: TimeInterval) {
        self.position = position
        self.startTime = startTime
        self.initialPosition = position
        
        // Convert angle and speed to velocity components
        // angle is in degrees: 0 = right, 90 = straight up
        let angleRadians = angle * .pi / 180.0
        
        // For an artillery game, we need to consider which direction the player is facing
        // We'll calculate vx and vy based on the angle
        let vx = speed * cos(angleRadians)
        let vy = speed * sin(angleRadians)
        
        self.velocity = CGVector(dx: vx, dy: vy)
        self.initialVelocity = self.velocity
    }
    
    // Update position based on time elapsed since firing
    // This uses the kinematic equations:
    // x(t) = x0 + vx * t
    // y(t) = y0 + vy * t + 0.5 * g * t²
    func updatePosition(currentTime: TimeInterval) {
        let t = CGFloat(currentTime - startTime)
        
        // Calculate new position using physics equations
        position.x = initialPosition.x + initialVelocity.dx * t
        position.y = initialPosition.y + initialVelocity.dy * t + 0.5 * gravity * t * t
        
        // Update velocity (vx stays constant, vy changes due to gravity)
        velocity.dx = initialVelocity.dx
        velocity.dy = initialVelocity.dy + gravity * t
    }
}
