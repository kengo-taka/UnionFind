//
//  PathCompression.swift
//  Union
//
//  Created by Takamiya Kengo on 2021-04-08.
//
import Foundation

/// The UF struct represents a union-find (disjoint sets) data structure
/// It supports **union** and **find** operations, along with methods for
/// determining whether two nodes are in the same component and the total
/// number of components.
/// This implementation uses weighted quick union (by size or rank) with
/// full path compression.
/// Initializing a data structure with **n** nodes takes linear time.
/// Afterwards, **union**, **find**, and **connected** take logarithmic time
/// (in the worst case) and **count** takes constant time.
/// Moreover, the amortized time per **union**, **find**, and **connected** operation
/// has inverse Ackermann complexity (which is practically < 5 for 2^(2^(2^(2^16))) - undefined number).
public struct PathCompressionUF {
    /// parent[i] = parent of i
    private var parent: [Int]
    /// size[i] = number of nodes in tree rooted at i
    private var size: [Int]
    /// number of components
    private(set) var count: Int
    
    /// Initializes an empty union-find data structure with **n** elements
    /// **0** through **n-1**.
    /// Initially, each elements is in its own set.
    /// - Parameter n: the number of elements
    public init(_ n: Int) {
        self.count = n
        self.size = [Int](repeating: 1, count: n)
        self.parent = [Int](repeating: 0, count: n)
        for i in 0..<n {
            self.parent[i] = i
        }
    }
    
    /// Returns the canonical element(root) of the set containing element `p`.
    /// - Parameter p: an element
    /// - Returns: the canonical element of the set containing `p`
    public mutating func find(_ p:inout Int) -> Int {
      while p != parent[p] {
        parent[p] = parent[parent[p]];
        p = parent[p]
      }
        return p
    }
    
    /// Returns `true` if the two elements are in the same set.
    /// - Parameters:
    ///   - p: one elememt
    ///   - q: the other element
    /// - Returns: `true` if `p` and `q` are in the same set; `false` otherwise
    public mutating func connected(_ p: Int, _ q: Int) -> Bool {

        return parent[p] == parent[q]
    }
    
    /// Merges the set containing element `p` with the set containing
    /// element `q`
    /// - Parameters:
    ///   - p: one element
    ///   - q: the other element
    public mutating func union(_ p: Int, _ q: Int) {
      if parent[p] == parent[q] {
        return
      }
      if size[p] > size[q] {
        size[p] += size[q]
        parent[q] = p
      } else {
        size[q] += size[p]
        parent[p] = q

      }
    }
}
