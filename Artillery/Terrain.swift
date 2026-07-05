//
//  Terrain.swift
//  Artillery
//
//  Terrain model - stores height data and generates simple hills
//

import Foundation
import CoreGraphics

class Terrain {
    // Array of heights, one per x-coordinate across the screen width
    // Index = x coordinate, value = y height at that position
    var heights: [CGFloat] = []
    
    let width: CGFloat
    let baseHeight: CGFloat  // minimum height of terrain
    
    init(width: CGFloat, baseHeight: CGFloat = 100) {
        self.width = width
        self.baseHeight = baseHeight
        generateTerrain()
    }
    
    // Generate a simple jagged hill silhouette
    private func generateTerrain() {
        let numPoints = Int(width)
        heights = []
        
        // Create a simple random hill pattern
        // We'll use a few random "peak" points and interpolate between them
        let numPeaks = 5
        var peakPositions: [Int] = []
        var peakHeights: [CGFloat] = []
        
        // Generate random peaks
        for i in 0...numPeaks {
            let x = Int(CGFloat(i) / CGFloat(numPeaks) * CGFloat(numPoints))
            let h = baseHeight + CGFloat.random(in: 50...200)
            peakPositions.append(x)
            peakHeights.append(h)
        }
        
        // Interpolate between peaks to create the terrain
        for x in 0..<numPoints {
            // Find which two peaks this x is between
            var leftPeakIndex = 0
            for i in 0..<peakPositions.count {
                if peakPositions[i] <= x {
                    leftPeakIndex = i
                }
            }
            
            let rightPeakIndex = min(leftPeakIndex + 1, peakPositions.count - 1)
            
            if leftPeakIndex == rightPeakIndex {
                heights.append(peakHeights[leftPeakIndex])
            } else {
                // Linear interpolation between the two peaks
                let x1 = CGFloat(peakPositions[leftPeakIndex])
                let x2 = CGFloat(peakPositions[rightPeakIndex])
                let y1 = peakHeights[leftPeakIndex]
                let y2 = peakHeights[rightPeakIndex]
                
                let t = (CGFloat(x) - x1) / (x2 - x1)
                let h = y1 + (y2 - y1) * t
                heights.append(h)
            }
        }
    }
    
    // Get the terrain height at a specific x coordinate
    func heightAt(x: CGFloat) -> CGFloat {
        let index = Int(x)
        if index < 0 || index >= heights.count {
            return baseHeight
        }
        return heights[index]
    }
}
