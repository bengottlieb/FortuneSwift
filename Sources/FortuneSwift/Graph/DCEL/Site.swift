//
//  Site.swift
//  Voronoi
//
//  Created by Tate on 2020-07-09.
//  Copyright © 2020 Tate Liang. All rights reserved.
//

import Foundation

/** Defines a site of a voronoi diagram. */
public class Site: Equatable, Hashable {
	
	public var x: Double
	public var y: Double
	
	//An edge along a border of the cell of this site
	public weak var firstEdge: HalfEdge?
	public var surroundingEdges: [HalfEdge]? {
		firstEdge?.walk()
	}
	
	public var isEmpty: Bool { firstEdge?.next == nil }
	public var containsBreakpoint: Bool { firstEdge?.breakpoint != nil }
	
	public var coordinate: CGPoint {
		CGPoint(x: x, y: y)
	}
	
	public init(x: Double, y: Double) {
		self.x = x
		self.y = y
	}
	public init(_ coordinate: CGPoint) {
		self.x = coordinate.x
		self.y = coordinate.y
	}
	
	public func hash(into hasher: inout Hasher) {
		Set(surroundingEdges ?? []).hash(into: &hasher)
	}
	
	public static func == (lhs: Site, rhs: Site) -> Bool {
		Set(lhs.surroundingEdges ?? []) == Set(rhs.surroundingEdges ?? [])
	}
}


//MARK: - Debug

extension Site: CustomStringConvertible {
	public var description: String {
		"\(round(x*10)/10), \(round(y*10)/10)"
	}
}
