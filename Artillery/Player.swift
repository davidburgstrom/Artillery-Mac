//
//  Player.swift
//  Artillery
//
//  Player model - stores position and player number
//

import Foundation
import CoreGraphics

class Player {
    let playerNumber: Int  // 1 or 2
    var position: CGPoint  // position on terrain
    
    // Aiming parameters
    var angle: CGFloat = 45  // degrees, 0 = right, 90 = straight up
    var velocity: CGFloat = 300  // initial velocity in points/second
    
    init(playerNumber: Int, position: CGPoint) {
        self.playerNumber = playerNumber
        self.position = position
    }
}
