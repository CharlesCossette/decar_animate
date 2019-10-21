# decar-animate

This repository is a library of different 3D animation classes. These animations are entirely position and DCM-based. To create an animation, start by creating an animation object

    ani = Animation()

You can then add "elements" to this animation and display the first instance,

    box1 = AnimatedBox()
    cone1 = AnimatedCone()
    ani.addElement(box1)
    ani.addElement(cone1)
    ani.build
    
Elements are simply graphical entities that will appear in the plot. The argument of `ani.addElement()` must be a valid animation object with appropriate `plot(r,C)` and `update(r,C)` functions. For instance,

    box1 = AnimatedBox()
    box1.plot(r,C)

will display a figure with a 1-by-1-by-1 box centered at `r`, and `C = C_ba` is a DCM relating an attached frame to the local coordinate frame. Alternatively, you may skip instantiating the class and put the class name directly in the `ani.addElement()` method,

    ani = Animation()
    ani.addElement(AnimatedBox)
    
You may also create `n` copies of a specific graphical entity using

    n = 3
    ani.addElement(AnimatedBox, n)
