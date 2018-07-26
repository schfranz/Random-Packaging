classdef FillSphere < Sphere & FillShapeInterface %order determines which superclass constructor is used!
    %class that inherits from Sphere and implements FillShapeInterface
    %FillSphere is a Sphere object that can be used to fill a shape 
    %   implementing FillableShapeInterface 
    
    %inherited properties:
        %from class Sphere:
        %volume     %volume of sphere       %protected
        %shape      %sphere                 %protected
        %height     %diameter
        %width      %diameter
        %depth      %diameter
        %center     %center coordinates     %default: [0,0,0]
        %radius     %radius of sphere
        %diameter   %diameter of sphere
        %from abstract class FillShapeInterface:
        %movable = true;         %true if a FillShape can be moved
        %transpShape = false;    %true if a FillShape is transparent to other FillShapes, i.e. it is allowed to overlap
        %transpWall = false;     %true if a FillShape is transparent to the wall of the surrounding Fillable object, i.e. it can stick out
        %neighbors       %list of neighbors FillShape needs to be aware of
        %outerShape      %an object that implements FillableShapeInterface and contains the FillShape
        
    %needs to implement:
        %for FillShapeInterface:
        %updateNeighbors(obj) %update list of neighbors as more objects are added
        %checkSurroundings(obj) %drops cones in all directions to see if there is more space elsewhere
        
    %%
    %%VARIABLES
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%
    %%FUNCTIONS
    %%CONSTRUCTOR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    
end