# decar-animate
## Table of Contents
[TOC]

## Setup
All you need to do is add the entire `decar_animate` folder to the Matlab path. This can be done a variety of ways, the simplest being to right-click on the the folder in the Matlab folder explorer and choosing

    Add to Path > Selected Folder and Subfolders

### Adding as a git submodule
It is probably convenient to add this repo as a `submodule` for whatever other main repo you are using for your project. To do this, go to your main repo directory, open a terminal/git command lind and type


    git submodule add https://YOUR_BITBUCKET_USERNAME@bitbucket.org/decargroup/decar_animate.git
    git submodule init
    git submodule update
    
More info on submodules: https://www.atlassian.com/git/tutorials/git-submodule 
## Building the animation
This repository is a library of different 3D animation classes. These animations are entirely position and DCM-based. To create an animation, start by creating an animation object

    ani = Animation() 

You can then add "elements" to this animation and display the first instance,

    ani.Animation()
    box1 = AnimatedBox()
    cone1 = AnimatedCone()
    ani.addElement(box1)
    ani.addElement(cone1)
    ani.build
    
The `ani.build` function intializes all the elements and generates them within a figure. This must be done before running the animation. You may skip instantiating the class and put the class name directly in the `ani.addElement()` method,
    
    ani = Animation()
    ani.addElement(AnimatedBox)
    ani.build
    
You may also create `n = 3` copies of a specific graphical entity using

    ani = Animation()
    ani.addElement(AnimatedBox, 3)
    ani.build
    
See this for yourself by typing `ani.elements` in the command window!

## Updating the animation
Once your animation has been built, you may use

    ani.update(r,C)
    
to translate and rotate the elements. 

`r` is a **[3 x number of elements]** matrix that contains the positions of the elements (usually their centroids) relative to the figure frame origin, resolved in the figure frame (r_zw_a).

`C` is a **[3 x 3 x number of elements]** matrix of Direction Cosine Matrices (DCMs) that describe the elements' attached body frames to the figure frame (C_ba).

**NOTE: the order of the different positions in the `r` and `C` matrices correspond to the elements *in the order in which they were added*. **

The `ani.update(r,C)` can be inserted inside a loop to create a moving animation.

## Customizing the appearances
### Customizing the elements themselves
This can be done by creating an instance of the element before adding it.

    ani = Animation()
    box = AnimatedBox()
    box.length = 5
    box.width = 3
    box.height = 2
    ani.addElement(box)

    
### Customizing the plots
The default appearance of the animations can easily be changed after building.

    ani = Animation()
    ani.addElement(AnimatedBox, 3)
    ani.build
    
    axis([0 10 -5 10 -inf inf])
    title('My Animation')
    xlabel('North')
    ylabel('East')
    zlabel('Altitude')
    grid on

The animation class does not enforce any figure or axis properties apart from some default values when it builds.

## Multiple Animations in Subplots
Want multiple different animations side by side? No problem! 

    figure(1)
    subplot(1,2,1)
    ani1 = Animation()
    ani1.addElement(AnimatedBox())
    ani1.build
    
    subplot(1,2,2)
    ani2 = Animation()
    ani2.addElement(AnimatedBox())
    ani2.build
    
Each animation can then be updated using `ani1.update(r,C)` and `ani2.update(r,C)` and so on. See the `swarmControl1` demo!


## Creating a new element class
Elements are simply graphical entities that will appear in the plot. The argument of `ani.addElement()` must be a valid animation object with appropriate `plot(r,C)` and `update(r,C)` functions. For instance,

    box1 = AnimatedBox()
    box1.plot(r,C)

will display a figure with a 1-by-1-by-1 box centered at `r`, and `C = C_ba` is a DCM relating an attached frame to the local coordinate frame

# TO DO

- [ ] Develop ani.play(r,C) to play back a set of data in real-time by monitoring computer clock (or n times real-time). 
- [ ] Develop ani.record(r,C) to record a video and save as .mp4 file (real-time or n times real-time).
- [ ] Write API for everything
- [ ] Implement tests for everything
- [ ] Expand customization of all the elements
- [ ] Create element abstract class
- [ ] Turn this repo into a MATLAB package?