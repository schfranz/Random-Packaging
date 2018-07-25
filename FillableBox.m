classdef FillableBox < Box & FillableShapeInterface %order determines which superclass constructor is used!
    %class that inherits from Box and implements FillableShapeInterface
    %FillableBox is a Box object that can be filled with a shape 
    %   implementing FillShapeInterface
    
    %inherited properties:
        %from class Box:
        %volume     %volume of box       %protected
        %shape      %box                 %protected
        %height     %longest side
        %width      %medium side
        %depth      %shortest side
        %center     %center coordinates     %default: [0,0,0]
        %diagonal   %body diagonal
        %from abstract class FillableShapeInterface:
        %freeVolume          %free volume when FillShape is inside
        %isFilled = false    %true when a FillShape present
        
    %needs to implement:
        %for FillableShapeInterface:
        %canFillHere(obj)
        
    %%
    %%VARIABLES
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%
    %%FUNCTIONS
    %%CONSTRUCTOR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    
end