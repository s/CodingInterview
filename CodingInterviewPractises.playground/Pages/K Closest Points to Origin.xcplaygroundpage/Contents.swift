//: [Previous](@previous)
/*:
 
 # 973. K Closest Points to Origin
 
 Given an array of points where points[i] = [xi, yi] represents a point on the X-Y plane and an integer k, return the k closest points to the origin (0, 0).

 The distance between two points on the X-Y plane is the Euclidean distance (i.e., √(x1 - x2)2 + (y1 - y2)2).

 You may return the answer in any order. The answer is guaranteed to be unique (except for the order that it is in).
 */
import Foundation
struct Point: Comparable {
  let x: Int
  let y: Int
  private(set) var distance: Double
  
  init(x: Int, y:Int) {
    self.x = x
    self.y = y
    self.distance = 0
  }
  
  mutating func updateDistanceToOrigin(_ distance: Double) {
    self.distance = distance
  }
  
  static func < (lhs: Point, rhs: Point) -> Bool {
    lhs.distance < rhs.distance
  }
  
  mutating func calculateDistanceToOrigin() {
    let origin = Point(x: 0, y:0)
    let xDist = pow(Double(self.x - origin.x), 2)
    let yDist = pow(Double(self.y - origin.y), 2)
    self.distance = sqrt(xDist + yDist)
  }
}

func kClosest(_ points: [[Int]], _ k: Int) -> [[Int]] { //O(nlogn)
  // if the points is empty
  //guard k > 0 else { return Array(repeated: 1 }
  var _points: [Point] = []
  points.forEach { point in // On
    if point.count == 2 {
      _points.append(Point(x:point[0], y: point[1])) // Point(x:-1, y:1)
    }
  }
  
  // [Point, Point, ...]
  for i in 0..<_points.count { //On
    _points[i].calculateDistanceToOrigin()
  }
  
  //
  _points = _points.sorted() // O(nlogn)
  
  // O(n)
  return _points.prefix(k).map { point -> [Int] in
    return [point.x, point.y]
  }
}

let points = [[-1,1], [1,1], [1,-2]]
print(kClosest(points, 1))

//: [Next](@next)
