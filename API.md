# API Documentation 
 [TOC] 
## Animated2TagQuad
  Quadcopter visual model - an element of elements.
  Includes property of the  location of the seconadry w.r.t. the base 
    tag in the body frame; i.e., r_iasti_b.
  Supports varying tag positions in the x-y plane. 
  TODO: 1) Consider the z-axis entry.

    
![Picture of Animated2TagQuad](./doc/Animated2TagQuad.png)
## AnimatedBox
  AnimatedBox Creates a simple 1x1x1 box/cube.
  The dimensions face color, edge color, and dimensions can all be modified be
  accessing the corresponding properties.
 
  *AnimatedBox Properties:*
 
     length - [float] x-dimension of box. 
     width  - [float] y-dimension of box. 
     height - [float] z-dimension of box. 
     faceAlpha - [float] Transparency of box on scale of 0 (transparent) to
     1. 
     edgeAlpha - [float] Transparency of edges on scale of 0 (transparent)
     to 1. 
     faceColor - [1 x 3 float] RGB triplet specifying face color. 
     edgeColor - [1 x 3 float] RGB triplet specifying edge color.

    
![Picture of AnimatedBox](./doc/AnimatedBox.png)
## AnimatedCone
 ANIMATEDCONE Creates a cone element, or a "chopped" cone element by
  specifying the two radii at each end of the cone, and the length of
  the cone. 
 
  *AnimatedCone Properties:*
 
     baseRadius - [float] radius of circle at one end of the cone.
     tipRadius  - [float] radius of circle at the other end of the cone.
     length     - [float] length of the cone
     faceAlpha  - [float] Transparency of box on scale of 0 (transparent) to
     1. 
     edgeAlpha  - [float] Transparency of edges on scale of 0 (transparent)
     to 1. 
     faceColor  - [1 x 3 float] RGB triplet specifying face color. 
     edgeColor  - [1 x 3 float] RGB triplet specifying edge color. 
     meshResolution - [int] Amount of segments in the circle.

    
![Picture of AnimatedCone](./doc/AnimatedCone.png)
## AnimatedCylinder
  AnimatedCylinder Creates a simple cylinder.
 
  *AnimatedCylinder Properties:*
 
     radius - [float] or [1 x n float] fixed radius or radius profile. 
     height - [float] z-dimension of cylinder. 
     faceAlpha - [float] Transparency of box on scale of 0 (transparent) to
     1. 
     edgeAlpha - [float] Transparency of edges on scale of 0 (transparent)
     to 1. 
     faceColor - [1 x 3 float] RGB triplet specifying face color. 
     edgeColor - [1 x 3 float] RGB triplet specifying edge color. 
     meshResolution - [int] Amount of segments in the circle.

    
![Picture of AnimatedCylinder](./doc/AnimatedCylinder.png)
## AnimatedEllipsoid
  AnimatedEllipsoid Creates a simple ellipsoid.
 
  *AnimatedEllipsoid Properties:*
 
     xRadius - [float] radius in x direction
     yRadius - [float] radius in y direction
     zRadius - [float] radius in z direction
     faceAlpha - [float] Transparency of box on scale of 0 (transparent) to
     1. 
     edgeAlpha - [float] Transparency of edges on scale of 0 (transparent)
     to 1. 
     faceColor - [1 x 3 float] RGB triplet specifying face color. 
     edgeColor - [1 x 3 float] RGB triplet specifying edge color. 
     meshResolution - [int] Amount of segments in the circle.

    
![Picture of AnimatedEllipsoid](./doc/AnimatedEllipsoid.png)
## AnimatedHusky
  Clearpath Husky Ground vehicle visual model.

    
![Picture of AnimatedHusky](./doc/AnimatedHusky.png)
## AnimatedPolyhedron
 ANIMATEDPOLYHEDRON  Creates a CONVEX polyhedron by specifiying either the
 vertices or the A,b matrices corresponding to inequality set A*r <= b.

    
![Picture of AnimatedPolyhedron](./doc/AnimatedPolyhedron.png)
## AnimatedQuadcopter
  Quadcopter visual model - an element of elements.

    
![Picture of AnimatedQuadcopter](./doc/AnimatedQuadcopter.png)
## AnimatedSphere
AnimatedSphere is a class.
    self = AnimatedSphere

    
![Picture of AnimatedSphere](./doc/AnimatedSphere.png)
## AnimatedTagQuad
  Quadcopter visual model - an element of elements.

    
![Picture of AnimatedTagQuad](./doc/AnimatedTagQuad.png)
## AnimatedTrace
  Animated Trace class is a special class that will create a trajectory
  that "follows" a specific target element. This animation therefore
  traces out dynamically the target's trajectory as it travels along
  it.

    
