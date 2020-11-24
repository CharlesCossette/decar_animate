# API Documentation 
 [toc] 
## Animated2TagQuad
  ---------------------------------------------------------------------
  Quadcopter visual model - an element of elements.
  Includes property of the  location of the seconadry w.r.t. the base 
    tag in the body frame; i.e., r_iasti_b.
  Supports varying tag positions in the x-y plane. 
  TODO: 1) Consider the z-axis entry.
  ---------------------------------------------------------------------

    
## AnimatedBox
 ANIMATEDBOX  Creates a simple 1x1x1 box/cube.
  The face color, edge color, and dimensions can all be modified be
  accessing the corresponding properties.

    
## AnimatedCone
 ANIMATEDCONE Creates a cone element, or a "chopped" cone element by
 specifying the two radii at each end of the cone, and the length of
 the cone.

    
## AnimatedCylinder
AnimatedCylinder is a class.
    self = AnimatedCylinder

    
## AnimatedEllipsoid
AnimatedEllipsoid is a class.
    self = AnimatedEllipsoid

    
## AnimatedHusky
  Clearpath Husky Ground vehicle visual model.

    
## AnimatedPolyhedron
 ANIMATEDPOLYHEDRON  Creates a CONVEX polyhedron by specifiying either the
 vertices or the A,b matrices corresponding to inequality set A*r <= b.

    
## AnimatedQuadcopter
  Quadcopter visual model - an element of elements.

    
## AnimatedSphere
AnimatedSphere is a class.
    self = AnimatedSphere

    
## AnimatedTagQuad
  Quadcopter visual model - an element of elements.

    
## AnimatedTrace
  Animated Trace class is a special class that will create a trajectory
  that "follows" a specific target element. This animation therefore
  traces out dynamically the target's trajectory as it travels along
  it.

    
