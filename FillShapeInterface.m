classdef (Abstract) FillShapeInterface < ShapeInterface
    %abstract class that describes a 3-D shape that can fill another 3-D shape
    %inherited properties:
        %volume     %volume of shape        %protected
        %shape      %shape type             %protected
        %height     %height of shape
        %width      %width of shape
        %depth      %depth of shape
        %center     %center coordinates     %default: [0,0,0]
    
    %%
    %%VARIABLES
    %%PUBLIC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetObservable, AbortSet)
        movable = true;         %true if a FillShape can be moved
        transpShape = false;    %true if a FillShape is transparent to other FillShapes, i.e. it is allowed to overlap
        transpWall = false;     %true if a FillShape is transparent to the wall of the surrounding Fillable object, i.e. it can stick out
    
    end
    
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (Access = protected)
        neighbors       %list of neighbors FillShape needs to be aware of
    end
    
    %%
    %%FUNCTIONS
    %%ABSTRACT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    methods (Abstract)
        updateNeighbors(obj) %update list of neighbors as more objects are added
        checkSurroundings(obj) %drops cones in all directions to see if there is more space elsewhere
    
    end
end