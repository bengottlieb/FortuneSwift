//
//  VoronoiBrain.swift
//  Voronoi
//
//  Created by Tate on 2020-07-09.
//  Copyright © 2020 Tate Liang. All rights reserved.
//

import Foundation

/** The model for computing a voronoi diagram. */
public struct Voronoi {
    
    var fortune = Fortune()
    
    private var sites: [CGPoint] = []
    public var voronoiVertices: [Vertex]?
    public var voronoiEdges: [HalfEdge]?
    public var voronoiSites: [Site]?
    
    public init(sites: [CGPoint]? = nil, numPoints: Int, rect: CGRect) {
        
        self.sites = sites ?? generateRandomSites(num: numPoints, rect: rect)
        
        let output = fortune.calcVoronoi(from: self.sites, boundingRect: rect)
        voronoiVertices = output.vertices
        voronoiEdges = output.edges
        voronoiSites = output.sites
        
    }
    
    
    //MARK: - Generate Random Sites
    /**
     Generates a random number of points within the specified rect.
     - Parameter num: The number of points to generate.
     - Parameter rect: The specified rect.
     */
    private func generateRandomSites(num: Int, rect: CGRect) -> [CGPoint] {
        guard num >= 1 else { return [] }

        var generatedSites: [CGPoint] = []
        for _ in 1...num {
			  generatedSites.append(CGPoint(x: Double.random(in: rect.origin.x...(rect.origin.x + rect.size.width)),
													  y: Double.random(in: rect.origin.y...(rect.origin.y + rect.size.height))))
        }
        return generatedSites
    }
    
    
    
    //MARK: - Debug
    
    private func printVertices() {
        voronoiVertices?.forEach { vertex in
            print("---\(vertex)---")
            vertex.incidentEdges.forEach { edge in
                print("EDGE: \(edge)")
                print("NEXT: \(String(describing: edge.next))")
                print("PREV: \(String(describing: edge.prev))")
                print("INCIDENT: \(String(describing: edge.incidentSite))")
                print()
            }
            print("-----------")
            print()
        }
    }
}
